using UnityEngine;
using System.Collections;

public class InView : MonoBehaviour {

	float range = 1.5f;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		Ray ray = Camera.main.ScreenPointToRay(new Vector3(Screen.width /2, Screen.height / 2, 0));
		RaycastHit hit = new RaycastHit();
		Debug.DrawRay(ray.origin, ray.direction, Color.cyan);

		if (Physics.Raycast(ray, out hit, range)){
			if (hit.collider.gameObject.GetComponent<ItemStat>() != null){
				this.gameObject.GetComponent<AddItemStat>().OnLookEnter(hit.collider);
			}
		}
	}
}
