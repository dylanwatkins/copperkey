using UnityEngine;
using System.Collections;

public class PlayerSpawnController : MonoBehaviour 
{
public GameObject[] playerSpawnArray; //This is our playerSpawn variable, it is an array. An array is a list.
private int randNum;
	
	void Awake()
	{
		playerSpawnArray = GameObject.FindGameObjectsWithTag("PlayerSpawn");
	}
	// Use this for initialization
	void Start () 
	{
	
	}
	
	// Update is called once per frame
	void Update () 
	{
	
	}
	
	public GameObject GetRandomPlayerSpawn(int randNum)
	{
		randNum = Random.Range(0, (playerSpawnArray.Length));
		
		if (playerSpawnArray.Length > 0)
		{
			return playerSpawnArray[randNum];
		}
		else
		{
			return null;
		}
	}
}
