using UnityEngine;
using System.Collections;

public class InView : MonoBehaviour {

	float range = 2.0f;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		Ray ray = Camera.main.ScreenPointToRay(new Vector3(Screen.width /2, Screen.height / 2, 0));
		RaycastHit hit = new RaycastHit();
		Debug.DrawRay(ray.origin, ray.direction, Color.cyan);

		if (Physics.Raycast(ray, out hit, range) && hit.collider.gameObject.GetComponent<ItemStat>() != null){
			string type = hit.collider.gameObject.GetComponent<ItemStat>().type;

			if (type == "weapon" || type == "armor" || type == "accessory"){
				this.gameObject.GetComponent<AddItemStat>().OnLookEnter(hit.collider);
//				Debug.Log ("i see: " + hit.collider.gameObject.GetComponent<ItemStat>().itemName);
			}
			else if (type == "moveable"){
				this.gameObject.GetComponent<Actions>().MoveTheObject(hit.collider);
				Debug.Log ("i see: " + hit.collider.gameObject.name);

			}

		}
		else if (Physics.Raycast(ray, out hit, range) && hit.collider.gameObject.GetComponent<ItemStat>() == null) {
			Debug.Log("not looking at object");
			this.gameObject.GetComponent<Actions>().myMessage = "";
		}
	}
}
