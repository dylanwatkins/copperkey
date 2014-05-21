using UnityEngine;
using System.Collections;

public class GUIManager : MonoBehaviour {

	public RenderTexture MiniMapTexture;
	public Material MiniMapMaterial;
	public GUIStyle playerIcon;

	private float offset;

	void Awake () {
		offset = 10;
	}

	void OnGUI () {
		if (Event.current.type == EventType.Repaint) {
			Graphics.DrawTexture(new Rect(Screen.width - 256 - offset, offset, 256, 256), MiniMapTexture, MiniMapMaterial);
			GUI.Box(new Rect(Screen.width - 128 - offset, 128 + offset, 10, 10), "", playerIcon);
		}
	}
}
