using UnityEngine;
using System.Collections;

public class HealthBar : MonoBehaviour {

	public int health = 3;
	public GUIStyle healthIcon;
	
	void OnGUI () {
		for (int i = 0; i < health; i++) {
			GUI.Box(new Rect((18 * i) + 10, 10, 20, 20), "", healthIcon);
		}
	}
	
}
