﻿using UnityEngine;
using System.Collections;

public class AddItemStat : MonoBehaviour {

	Collider currentCollider;
	bool itemPickedUp = false;
	bool emptyWeapon = true;
	bool emptyArmor = true;
	bool emptyAccessory = true;
	string itemType;
	string itemName;
	Texture2D itemIcon;
	string weaponName;
	Texture2D weaponIcon;
	string armorName;
	Texture2D armorIcon;
	string accessoryName;
	Texture2D accessoryIcon;
	public GUIStyle itemBox;



	void OnTriggerEnter(Collider collider) {

		currentCollider = collider;
		Camera mainCamera = Camera.main;
		collider.transform.parent = mainCamera.transform;
		collider.enabled = false;
		itemPickedUp = true;

		if (currentCollider.GetComponent<ItemStat>().type == "weapon") {
			int currentStrength = this.gameObject.GetComponent<CharacterStats>().strength;
			int itemStrength = collider.gameObject.GetComponent<ItemStat>().strength;
			//subtract the old item's stats to get the character's base stats and then add the new strength
			this.gameObject.GetComponent<CharacterStats>().strength = currentStrength - (currentStrength % 5) + itemStrength;
			collider.transform.position = this.gameObject.transform.position;
			collider.transform.rotation = this.gameObject.transform.rotation;
			collider.transform.localPosition = new Vector3(0.591f, -0.192f, 1.132f);
			collider.transform.localScale = new Vector3(1.5f, 1.5f, 1.5f);
			collider.transform.Rotate(69.393f, 293.612f, 70.596f);
		}
		else if (currentCollider.GetComponent<ItemStat>().type == "armor"){
			collider.gameObject.SetActive(false);
			this.gameObject.GetComponent<CharacterStats>().armor = collider.gameObject.GetComponent<ItemStat>().armor;
		}
		else if (currentCollider.GetComponent<ItemStat>().type == "accessory"){
			collider.gameObject.SetActive(false);
			int currentHealth = this.gameObject.GetComponent<CharacterStats>().health;
			int itemHealth = collider.gameObject.GetComponent<ItemStat>().health;
			this.gameObject.GetComponent<CharacterStats>().health = currentHealth - (currentHealth % 5) + itemHealth;

		}


		
	}


	void OnGUI() {
		if (itemPickedUp){
			itemPickedUp = false;
			itemType = currentCollider.GetComponent<ItemStat>().type;
			itemName = currentCollider.GetComponent<ItemStat>().itemName;
			itemIcon = currentCollider.GetComponent<ItemStat>().itemIcon.normal.background;
			if(itemType == "weapon"){
				emptyWeapon = false;
				weaponName = itemName;
				weaponIcon = itemIcon;
			}
			else if(itemType == "armor"){
				emptyArmor = false;
				armorName = itemName;
				armorIcon = itemIcon;
			}
			else if(itemType == "accessory"){
				emptyAccessory = false;
				accessoryName = itemName;
				accessoryIcon = itemIcon;
			}
		}

		//Empty Item Boxes
		if (emptyWeapon){
			GUI.Box (new Rect(500, 40, 100, 100), "No Weapon", itemBox);
		}
		else if (emptyWeapon == false){
			GUI.Box(new Rect(500, 40, 100, 100), weaponIcon);
			GUI.Label(new Rect(500, 15, 100, 25), weaponName);
			GUI.Label(new Rect(500, 140, 100, 25), "Strength +" + currentCollider.GetComponent<ItemStat>().strength.ToString());
		}
		if (emptyArmor){
			GUI.Box (new Rect(610, 40, 100, 100), "No Armor", itemBox);
		}
		else if (emptyArmor == false){
			GUI.Box(new Rect(610, 40, 100, 100), armorIcon);
			GUI.Label(new Rect(610, 15, 100, 25), armorName);
			GUI.Label(new Rect(610, 140, 100, 25), "Armor +" + currentCollider.GetComponent<ItemStat>().armor.ToString());
		}
		if (emptyAccessory){
			GUI.Box (new Rect(720, 40, 100, 100), "No Accessory", itemBox);
		}
		else if (emptyAccessory == false){
			GUI.Box(new Rect(720, 40, 100, 100), accessoryIcon);
			GUI.Label(new Rect(720, 15, 100, 25), accessoryName);
			GUI.Label(new Rect(720, 140, 100, 25), "Health +" + currentCollider.GetComponent<ItemStat>().health.ToString());
		}

	}


}
