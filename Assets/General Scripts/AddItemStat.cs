using UnityEngine;
using System.Collections;

public class AddItemStat : MonoBehaviour {


	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
				
	}

	void OnTriggerEnter(Collider collider) {

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

		
	}
}
