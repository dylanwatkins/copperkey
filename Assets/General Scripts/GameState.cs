using UnityEngine;
using System.Collections;

public class GameState : MonoBehaviour 
{
private GameObject player;
	
private PlayerSpawnController playerSpawnCTRL;
	
private GameObject randPlayerSpawn;
	
	void Awake()
	{
		player = GameObject.FindWithTag("Player");
		playerSpawnCTRL = GameObject.FindGameObjectWithTag("PlayerSpawnCTRL").GetComponent<PlayerSpawnController>();
	}

	// Use this for initialization
	void Start () 
	{
		int randNum = 0;
		randPlayerSpawn = playerSpawnCTRL.GetRandomPlayerSpawn(randNum);
		
		SpawnPlayer();
	}
	
	// Update is called once per frame
	void Update () 
	{
	
	}
	
	void SpawnPlayer()
	{
		player.transform.position = randPlayerSpawn.transform.position;
		Debug.Log("You have spawned at " + randPlayerSpawn.name);
	}
}
