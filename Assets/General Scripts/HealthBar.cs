using UnityEngine;
using System.Collections;

public class HealthBar : MonoBehaviour {

	int health;
	public GUIStyle healthIcon;
	public CharacterController controller;

	void Start() {
		health = controller.GetComponent<CharacterStats>().health;
	}

	void OnGUI () {
		for (int i = 0; i < health; i++) {
			GUI.Box(new Rect((36 * i) + 200, 50, 40, 40), "", healthIcon);
		}
	}
	
}
