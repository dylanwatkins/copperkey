using UnityEngine;
using System.Collections;

public class GUIManager : MonoBehaviour {

	//variables
	int health;
	public GUIStyle playerIcon;
	public GUIStyle healthIcon;
	public CharacterController controller;


	void Start() {
		//load amount of health
		health = controller.GetComponent<CharacterStats>().health;
	}

	void Awake () {

	}

	void OnGUI () {
		//Hearts
		health = controller.GetComponent<CharacterStats>().health;
		for (int i = 0; i < health; i++) {
			GUI.Box(new Rect((36 * i) + 150, 50, 40, 40), "", healthIcon);
		}

		//Target
		GUI.Box(new Rect(Screen.width/2 - 2, Screen.height/2 - 20, 4, 40), "", playerIcon);
		GUI.Box(new Rect(Screen.width/2 - 20, Screen.height/2 - 2, 40, 4), "", playerIcon);



	}
}
