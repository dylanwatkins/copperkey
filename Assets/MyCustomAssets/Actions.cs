using UnityEngine;
using System.Collections;

public class Actions : MonoBehaviour {

//	bool lookingAtObject = false;
	public string myMessage = "";
	float range = 2.0f;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

		StillInView();
//		if (!lookingAtObject){
//		myMessage = "";
//		}
	}

	public void MoveTheObject(Collider collider){
//		Debug.Log("looking at: " + collider.name  + message);
		if (Camera.main.transform.childCount > 0){
			foreach (Transform child in Camera.main.transform){
//				Debug.Log(child.gameObject.GetComponent<ItemStat>().itemName == "Shovel");
				if (child.gameObject.GetComponent<ItemStat>().itemName == "Shovel"){
//					Debug.Log("you have shovel" + message);
					myMessage = "Left Click";
//					Debug.Log(message);
//					lookingAtObject = true;
					if (Input.GetMouseButtonUp(0)){
						collider.gameObject.SetActive(false);
						myMessage = "";
					}
				}
				else {
//					Debug.Log("you need to have the shovel" + message);
				}
			}
		}
		else {
//			Debug.Log("you have no items" + message);
		}

	}

	void OnGUI () {
//		Debug.Log(myMessage);
			GUI.Label(new Rect(Screen.width / 2 - 25, Screen.height / 2 - 50, 80, 20), myMessage);

	}

	void StillInView() {
//		Ray ray = Camera.main.ScreenPointToRay(new Vector3(Screen.width /2, Screen.height / 2, 0));
//		RaycastHit hit = new RaycastHit();
//
//		if (Physics.Raycast(ray, out hit, range) && hit.collider.gameObject.GetComponent<ItemStat>() != null){
//			string type = hit.collider.gameObject.GetComponent<ItemStat>().type;
//			if (type != "weapon" || type != "armor" || type != "accessory" || type != "moveable")	{
//				myMessage = "";
//			}
//
//		}
	}

}
