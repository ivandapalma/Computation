package competition.uhu.ivandapalma;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

//import org.objectweb.asm.util.CheckMethodAdapter;

import ch.idsia.agents.Agent;
//import ch.idsia.agents.AgentLoader;
import ch.idsia.agents.controllers.BasicMarioAIAgent;
import ch.idsia.benchmark.mario.engine.sprites.Mario;
import ch.idsia.benchmark.mario.environments.Environment;
import ch.idsia.benchmark.mario.environments.MarioEnvironment;
//import ch.idsia.utils.MathX;

public class IvanDaPalma extends BasicMarioAIAgent implements Agent
{
	public static String projectStatus = "TEST"; // "TEST" or "TRAIN"
	
//	private static Agent agent;
	private static Environment environment;
	protected boolean action[];
	private static int currentStatus;
	private static int currentAction;    
    private static int newStatus; 
    private static int marioX;   
//    private static int marioY;  
	private static int qRows = 5; // Status:	Running, Jumping, EnemyClose, ObstacleClose, Stuck
	private static int qCols = 3; // Actions:	RunRight, Jump, Left //, Shoot    				// Nothing
	private static int Q[][] = new int[qRows][qCols];
    
	// PARAMETERS
	private static double gamma = 0.3;		// Discount factor
    private static double alpha = 0.7;  	// Learning rate
    private static double epsilon = 0.9;	// Random probability 
	private static int iterations = 0;
//	private static int increaseEpsilon = 500;
	private static int checkStuck = 15;
	private static int iStuck = 1;
	private static int reward = 8;
	private static int stompKills = 0;
	
	// Mario Modes
	private static int marioMode;
	private static int MODE_SMALL = 0;
	private static int MODE_BIG = 1;
	private static int MODE_FIRE = 2;
	
	// Available actions. ORDER KEYS: [LEFT, RIGHT, DOWN, JUMP, SPEED, UP]
	//private static int ACTION_RUNLEFT = 0;
	private static int ACTION_RUNRIGHT = 0;
	private static int ACTION_JUMP = 1;
	private static int ACTION_LEFT = 2;
	
	//private static int ACTION_DONOTHING = 4;	
	//private static boolean[] runLeft = new boolean[]{true, false, false, false, true, false};
	private static boolean[] runRight = new boolean[]{false, true, false, false, true, false};
	private static boolean[] jump = new boolean[]{false, false, false, true, false, false};
	private static boolean[] runLeft = new boolean[]{true, false, false, false, false, false};
	//private static boolean[] doNothing = new boolean[]{false, false, false, false, false, true};
	
	// Available states.
	private static int STATUS_RUNNING = 0;
	private static int STATUS_JUMPING = 1;
	private static int STATUS_ENEMYCLOSE = 2;
	private static int STATUS_OBSTACLECLOSE = 3;
	private static int STATUS_STUCK = 4;
	
    // Final States to give rewards
    // Mario.STATUS_WIN -> +100
    // Mario.STATUS_DEAD -> -100
    // Mario.STATUS_RUNNING; +60 if Mario is still alive
      
		
	public IvanDaPalma(String name)
	{
		super(name);
		action = new boolean[Environment.numberOfKeys];
		//agent.setName(name); // Falla aquí. Agente nulo ?????
		//integrateObservation(environment);
		//environment.setAgent(agent);
		action = jump;
		currentStatus = STATUS_JUMPING;
		currentAction = ACTION_JUMP;
		iterations = 1;
		marioMode = MODE_FIRE;
		
		String newFile = "src/competition/uhu/ivandapalma/IvanDaPalma_Q.txt";
		File f = new File(newFile);
		if(f.exists() && !f.isDirectory()) {
			Q = loadTableQ(newFile);
			System.out.println("Cargando Tabla Q...");
		}
		else
			initializeQTable();
		
		if(projectStatus.equals("TEST"))
		{
			System.out.println("TEST");
			epsilon = 1.1;
		}
		else
		{
			System.out.println("TRAIN");
			epsilon = 0.8;
		}
			
	}
	
	public static void setEnvironment(Environment environment){
		IvanDaPalma.environment = environment;
	}
	
	public boolean[] getAction()
	{ 
		/*
		if(currentStatus == 0)
			System.out.println("CORRIENDO");
		else if(currentStatus == 1)
			System.out.println("SALTANDO");
		else if(currentStatus == 2)
			System.out.println("DISPARANDO");g
		*/
		  
		// Q-Learning Algorithm
		
		// Get status
		newStatus = getCurrentStatus();
		
//		System.out.println("Estado: "+newStatus);
//		if(newStatus != currentStatus)
//		{
//			if(newStatus == 0)
//				System.out.println("Estado: CORRIENDO. Acción: "+currentAction);
//			else if(newStatus == 1)
//				System.out.println("Estado: SALTANDO. Acción: "+currentAction);
//			else if(newStatus == 2)
//				System.out.println("Estado: ENEMIGO CERCA. Acción: "+currentAction);
//			else if(newStatus == 2)
//				System.out.println("Estado: OBSTACULO. Acción: "+currentAction);
//			else //if(newStatus == 4)
//				System.out.println("Estado: ATASCADO. Acción: "+currentAction);
//		}
		
		if(projectStatus.equals("TRAIN"))	
		{
			// Watch next status and Give Reward depends on Mario state
			reward = 0;
			reward = getReward();
			//System.out.println("Reward: "+reward);
			
			if(reward < 0 || reward == 10)
			{
				// Update Q
				//int qq = Q[currentStatus][currentAction];
				
//				printQ();
				
				updateQ();
				//System.out.println("Q: " + qq + " -> "+Q[currentStatus][currentAction]);
				
//				printQ();
				
				saveTableQ("IvanDaPalma_Q.txt");
			}
		
		}
		
		// Select an action
		action = epsilonGreedyPolicy();		
		
		// New status is the new current status
		currentStatus = newStatus;
		
		iterations++;
		return action;
		
		
		/*
		do {
            chooseAction();
        }while(currentStatus == Mario.STATUS_WIN);
		return new boolean[Environment.numberOfKeys];
	    action[Mario.KEY_SPEED] = action[Mario.KEY_JUMP] = isMarioAbleToJump || !isMarioOnGround;
		*/
		
	}
	
	public static void updateQ()
	{
//		int tt;
		double t = alpha*(reward + gamma*maxQ(currentStatus) - Q[currentStatus][currentAction]);
		
//		System.out.println("\nStatus: "+newStatus+" Reward: "+reward+ " alpha: "+alpha+ " gamma: "+gamma+" maxQ: "+ maxQ(newStatus));//+ " t: "+t);
//		System.out.println("Ceil: "+(Q[currentStatus][currentAction]+t) + " "+ Math.ceil(Q[currentStatus][currentAction]+t));
//		if(t >= 0.5)
//			tt = 2;
//		else
//			tt = 0;
		
//		if(reward != 0)
//		{	
//			System.out.println("Q => "+Q[currentStatus][currentAction] +" + "+ alpha+" * ("+reward + " + "+gamma+" * "+maxQ(currentStatus)+" - "+ Q[currentStatus][currentAction]+") = "+Q[currentStatus][currentAction] + " + " +t+" = "+ (int)(Math.ceil(Q[currentStatus][currentAction]+t)));
//			System.out.println("\nQ: "+Q[currentStatus][currentAction] +" => " +(int)(Math.ceil(Q[currentStatus][currentAction]+t)) );
//		}
		
//		System.out.println("Grabar Q Antes: "+Q[currentStatus][currentAction]);
		if (Q[currentStatus][currentAction] >= 0)
			Q[currentStatus][currentAction]  = (int)(Math.ceil(Q[currentStatus][currentAction]+t));
		else
			Q[currentStatus][currentAction]  = (int)(Math.ceil(Q[currentStatus][currentAction]-t));
//		System.out.println("Grabar Q Despues: "+Q[currentStatus][currentAction]);
	}
	
	public void printQ()
	{
		System.out.print("\n");
		for (int i=0; i < Q.length; i++)
		{
			int l = Q[i].length;
			for (int j=0; j < l; j++)
				System.out.print(Q[i][j] + " ");
			System.out.print("\n");
			
		}
			
			
	}
	
	public int getCurrentStatus()
	{
		
		boolean isStuck = isMarioStuck();
		
		if (checkEnemies(environment))
		{	
			if(isStuck)
				return STATUS_STUCK;
			
			return STATUS_ENEMYCLOSE;		
		}
		
		else if(!checkEnemies(environment)
				&& !checkObstacles(environment)
//				&& !checkEnemiesWhileFalling(environment) 
				&& environment.isMarioAbleToJump()
//				&& environment.isMarioOnGround()
				&& !isStuck)
					return STATUS_RUNNING;		
		
		else if(!checkEnemies(environment)
				&& !checkObstacles(environment)
				&& !environment.isMarioAbleToJump()
//				&& !environment.isMarioOnGround()
				&& !isStuck)
					return STATUS_JUMPING;
		
		else if ((checkObstacles(environment) || checkHoles(environment))
				&& !checkEnemies(environment)
				//&& !checkEnemiesWhileFalling(environment)
				&& !isStuck)
			return STATUS_OBSTACLECLOSE;
		
		else if(isStuck)
			return STATUS_STUCK;
		
		else
		{
			//System.out.println("ESTADO INDEFINIDO. checkObstacles: "+checkObstacles(environment) + " checkEnemies: " +checkEnemies(environment) + " checkHoles: " +checkHoles(environment) + " isMarioStuck: "+isMarioStuck());
			if(isStuck)
				return STATUS_STUCK;
			else
				return STATUS_OBSTACLECLOSE;	
		}
				
		
		
	}
	
	public boolean isMarioStuck()
	{
		// Return Mario Current status
		if(iStuck == checkStuck)
		{
			iStuck = 0;
			marioX = marioEgoCol;
			if(marioEgoCol == marioX){ // ??
//				System.out.println("ATASCADOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO!!");
				return true;
			}
			else{
				marioX = marioEgoCol;
				return false;
			}
			
		}
		else
		{
			iStuck++;
			return false;
		}
		
	}
	
	public int getReward()
	{
		int r = 0;
		
		//System.out.println("Status: "+environment.getMarioStatus());
		if(environment.getMarioStatus() == Mario.STATUS_DEAD) // Mario is alive
		{
			r = -10;
		}
		else
		{
			//r = 4; // Staying alive
			
			// if(environment.getMarioStatus() == Mario.STATUS_WIN) // Mario is in goal state
			//		r = 10;	
			
			if(currentStatus == STATUS_STUCK && checkObstacles(environment) && environment.getMarioStatus() == STATUS_RUNNING)
				r = -5;
				
			if (environment.getKillsByStomp() != stompKills)
			{
				stompKills = environment.getKillsByStomp();
				r = 10;
			}
			
			if(environment.getMarioMode() != marioMode) 	// Mario has been hit
			{
//				System.out.println("Me han dadoooooooooooooooooooooooooooooooooooooooooooooooooooo!");
				r = -5;
				//iterations--;
				marioMode = environment.getMarioMode();				
			}
			
		}
	
		return r;
	}
	
	public static void initializeQTable()
	{
		Q = new int[qRows][qCols];
        Random rand = new Random(); 
        rand.setSeed(System.currentTimeMillis()); 
        for (int i = 0; i < qRows; i++) {     
            for (int j = 0; j < qCols; j++) {
                Integer r = rand.nextInt()%100; 
                Q[i][j] = Math.abs(r);
            }

        }
	}
	
	public boolean[] epsilonGreedyPolicy()
	{
		boolean[] act;		
		Random random = new Random();
		double num = (double)random.nextInt(10 + 1)/10; // Generate a double num between 0.0 and 1.0
		
		//System.out.println("Num generado: "+num+"\tEpsilon: "+epsilon);
		
		if (num > epsilon)
			act = getRandomAction(); 	// Exploration
		else
			act = chooseActionMaxQ(currentStatus);	// Exploitation			
		return act;
	}	
	
	private static boolean[] getRandomAction()
    {
		int indexAction = 0;
		
		// Randomly select a GOOD action depends on status
        indexAction = (int) (Math.random() * qCols); // Between 0 (inclusive) and qCols=5 (exclusive)
        //System.out.println("indexAction generado: "+indexAction);
    	
        currentAction = indexAction;        
        return actions(indexAction);
        
        /*
        boolean choiceIsValid = false;
        // Randomly select a GOOD action (positive)
        while(choiceIsValid == false)
        {
            // Get a random value between 0 (inclusive) and number (exclusive).
        	num = new Random().nextInt(number);
            if(Q[currentStatus][num] > -1){
                choiceIsValid = true;
            }
        }
        return act;
        */
        
    }
	
	public static boolean[] chooseActionMaxQ(int state)
	{
		
		int index = 0;
		int max = 0;
		for(int i = 0; i < qCols; i++)
		{
			if(Q[state][i] > max)
			{
				max = Q[state][i];
				index = i;
			}
		}
		//System.out.println("Cols: "+qCols+" Estado: "+ state + " Action: "+index+" Max: "+max);
		return actions(index);		
	}
	
	public static int maxQ(int state)
	{
		int maxS = Q[state][0];
		//System.out.println("MaxS: "+maxS);
		for(int i = 1; i < qCols; i++)
			if(Q[state][i] > maxS)
				maxS = Q[state][i];
		
		return maxS;		
	}
	
	
	public static boolean[] actions(int indexAction)
	{		
		//System.out.println("IndexAction: "+indexAction);
		switch(indexAction)
		{
			case 0:  return runRight;
			case 1:	 return jump;
			case 2:	 return runLeft;
			default: return jump;				
		}        
	}

	private boolean checkEnemies(Environment environment) 
	{
		byte[][] enemies = environment.getEnemiesObservationZ(2);
		if (
				((enemies[marioEgoRow][marioEgoCol + 1] != 0) && (enemies[marioEgoRow][marioEgoCol + 1] != 25)) ||
				((enemies[marioEgoRow][marioEgoCol + 2] != 0) && (enemies[marioEgoRow][marioEgoCol + 1] != 25)) ||
				((enemies[marioEgoRow][marioEgoCol - 1] != 0) && (enemies[marioEgoRow][marioEgoCol + 1] != 25)) ||
				((enemies[marioEgoRow][marioEgoCol - 2] != 0) && (enemies[marioEgoRow][marioEgoCol + 1] != 25))
			
			)
		{
	        //System.out.println("Cuidado enemigo cerca");
			return true;
	    }
		else
		{
			return false;
		}
	}
	
	
	private boolean checkObstacles(Environment environment)
	{
		
		byte[][] obstacles = environment.getLevelSceneObservationZ(1);
		if ((obstacles[marioEgoRow][marioEgoCol + 1] != 0 && obstacles[marioEgoRow][marioEgoCol + 1] != 2) ||
			(obstacles[marioEgoRow][marioEgoCol + 2] != 0 && obstacles[marioEgoRow][marioEgoCol + 2] != 2) ||
			(obstacles[marioEgoRow][marioEgoCol + 3] != 0 && obstacles[marioEgoRow][marioEgoCol + 3] != 2) ||
			(obstacles[marioEgoRow - 1][marioEgoCol + 1] != 0 && obstacles[marioEgoRow - 1][marioEgoCol + 1]!=2))
				return true; 
		else
				return false;
				
				
	}
	
	private boolean checkHoles(Environment environment) { //TODO : Ver lo de los hoyos
		
		byte[][] obstacles = environment.getLevelSceneObservationZ(2);
		
		if (obstacles[marioEgoRow + 1][marioEgoCol + 1] == 0)
		{
//			 System.out.println("HOYOOOOOOOOOOOOOOOO");
	         return true;
		}
		else
		{
			return false;
		}
	}
	
	
	
	public static void saveTableQ(String file)
    {
        try{ 

            FileWriter arch = new FileWriter(file); 
            PrintWriter write = new PrintWriter(arch); 
            
            for(int i=0; i<qRows; i++){ 
                for(int j=0; j<qCols; j++)
                { 
                      write.print(Q[i][j] + " "); 
                } 
                write.println(); 
            } 
 
            write.close(); 
        } 
        catch(IOException e){ 
            System.out.println("Error: " + e); 
        } 
    } 
	
	public static int[][] loadTableQ(String file)
    {
        String line = "";
        String cvsSplitBy = " ";
        int[][] newQ = new int[qRows][qCols];
                
        try (BufferedReader br = new BufferedReader(new FileReader(file)))
        {
            int i = 0;
            while ((line = br.readLine()) != null)
            {                
                String[] col = line.split(cvsSplitBy); // Complete line separated by comma
                for(int j=0; j < col.length; j++)
                    newQ[i][j] = Integer.parseInt(col[j]);
                i+=1;
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return newQ;
    }
	

	
}
