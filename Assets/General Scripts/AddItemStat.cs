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
		Destroy(collider.gameObject);

		
	}
}
