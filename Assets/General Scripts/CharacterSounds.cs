using UnityEngine;
using System.Collections;

public class CharacterSounds : MonoBehaviour {

	public AudioSource walkSound;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetButton("Horizontal") || Input.GetButton("Vertical")) {
			if (!walkSound.isPlaying){
				walkSound.Play();
			}
		}
		if (Input.GetButtonUp("Horizontal") || Input.GetButtonUp("Vertical")) {
			walkSound.Pause();
		}
	}
}
