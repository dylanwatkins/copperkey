using UnityEngine;
using System.Collections;

public class AddItemStat : MonoBehaviour {

	Collider currentCollider;
	bool itemPickedUp = false;
	bool emptyWeapon = true;
	bool emptyArmour = true;
	bool emptyAccessory = true;
	string itemType;
	string itemName;
	Texture2D itemIcon;
	string weaponName;
	Texture2D weaponIcon;
	public GUIStyle itemBox;
//	public Texture2D stuff;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
				
	}

	void OnTriggerEnter(Collider collider) {

		currentCollider = collider;

		int currentStrength = this.gameObject.GetComponent<CharacterStats>().strength;
		int itemStrength = collider.gameObject.GetComponent<ItemStat>().strength;
		if (currentStrength < itemStrength) {
			this.gameObject.GetComponent<CharacterStats>().strength = itemStrength;
		}

		Camera mainCamera = Camera.main;
		collider.transform.parent = mainCamera.transform;
		collider.transform.position = this.gameObject.transform.position;
		collider.transform.rotation = this.gameObject.transform.rotation;

		collider.transform.localPosition = new Vector3(0.591f, -0.192f, 1.132f);
		collider.transform.localScale = new Vector3(1.5f, 1.5f, 1.5f);
//		Debug.Log(collider.transform.position);
		collider.transform.Rotate(69.393f, 293.612f, 70.596f);
		collider.enabled = false;
		//Destroy(collider.gameObject);
		itemPickedUp = true;

		
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
			else if(itemType == "armour"){
				emptyArmour = false;
			}
		}

		//Empty Item Boxes
		if (emptyWeapon){
			GUI.Box (new Rect(500, 40, 100, 100), "Empty", itemBox);
		}
		else if (emptyWeapon == false){
			GUI.Box(new Rect(500, 40, 100, 100), weaponIcon);
			GUI.Label(new Rect(500, 15, 100, 25), weaponName);
			GUI.Label(new Rect(500, 140, 100, 25), "Strength +" + (this.GetComponent<CharacterStats>().strength - 5).ToString());
		}
		if (emptyArmour){
			GUI.Box (new Rect(610, 40, 100, 100), "Empty", itemBox);
		}
		if (emptyAccessory){
			GUI.Box (new Rect(720, 40, 100, 100), "Empty", itemBox);
		}

	}


}
