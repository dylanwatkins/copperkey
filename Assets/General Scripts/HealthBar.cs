using UnityEngine;
using System.Collections;

public class HealthBar : MonoBehaviour {

	public int health;
	public GUIStyle healthIcon;
	public CharacterController controller;

	void Start() {
		health = controller.GetComponent<CharacterStats>().health;
	}

	void OnGUI () {
		for (int i = 0; i < health; i++) {
			GUI.Box(new Rect((18 * i) + 10, 10, 20, 20), "", healthIcon);
		}
	}
	
}
