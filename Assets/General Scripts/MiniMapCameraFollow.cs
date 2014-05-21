using UnityEngine;
using System.Collections;

public class MiniMapCameraFollow : MonoBehaviour {

				
	public Transform Target;
	
	// Update is called once per frame
	void Update () {
		transform.position = new Vector3(Target.position.x, transform.position.y, Target.position.z);
	}
}
