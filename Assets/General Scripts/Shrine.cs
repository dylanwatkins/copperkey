using UnityEngine;
using System.Collections;

public class Shrine : MonoBehaviour 
{

	// Use this for initialization
	void Start () 
	{
		
	
	}
	
	// Update is called once per frame
	void Update () 
	{
	
	}
	
	void OnTriggerEnter(Collider player)
	{
		Application.LoadLevel("10_Begin");	
	}
}
