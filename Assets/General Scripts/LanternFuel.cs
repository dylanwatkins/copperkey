using UnityEngine;
using System.Collections;

public class LanternFuel : MonoBehaviour 
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
		player.gameObject.SendMessage("FuelPickup");
		Destroy(this.gameObject);
	}
}
