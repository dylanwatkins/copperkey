using UnityEngine;
using System.Collections;

public class Inventory : MonoBehaviour 
{
public int fuelAmount = 0;
//public AudioClip fuelCollectedSound; --Used if we want sound on the item pickup

public Texture2D[] hudFuelAmount;
public GUITexture fuelAmountHUDGUI;
	
public Light lanternLight;

public float origFuelTimer = 30.0f;
public float fuelTimer = 0.0f;
public float origFuelGUITimer = 30.0f;
public float fuelGUITimer = 0.0f;
public int maxFuelAmount;
	
	// Use this for initialization
	void Start () 
	{
		fuelAmount = 0;
		lanternLight = GameObject.Find("Lantern").GetComponent<Light>();
		maxFuelAmount = hudFuelAmount.Length;
	}
	
	// Update is called once per frame
	void Update () 
	{
		if(fuelTimer > 0.0f)
		{
			fuelTimer -= Time.deltaTime;
		}
		if(fuelTimer < 0.0f)
		{
			lanternLight.light.intensity = 0.0f;
		}
		if(fuelGUITimer > 0.0f && fuelAmount > 0)
		{
			fuelGUITimer -=Time.deltaTime;
		}
		if(fuelGUITimer < 0.0f)
		{
			RemoveGUIFuel();
		}
	}
	
	void FuelPickup()
	{
		if(fuelAmount < maxFuelAmount - 1)
		{
			fuelTimer += origFuelTimer;
			//AudioSource.PlayClipAtPoint(fuelCollectedSound, transform.position); --Used if we want sound on item pickup
			fuelAmount++;
			fuelAmountHUDGUI.texture = hudFuelAmount[fuelAmount];
			lanternLight.light.intensity = 1.0f;
		
			if(fuelGUITimer == 0.0f)
			{
				fuelGUITimer = origFuelGUITimer;
			}
		}
	}
	
	void RemoveGUIFuel()
	{
		if(fuelAmount > 0)
		{
			fuelAmount --;
			fuelAmountHUDGUI.texture = hudFuelAmount[fuelAmount];
			fuelGUITimer = origFuelGUITimer;
		}
	}
}
