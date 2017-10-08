using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Drop : MonoBehaviour {

	public GameObject start;
	public GameObject stop;
	public GameObject actualMesh;
	public float startTime;
	public float breathStartTime;
	public float bounceStartTime;
	public float speed = 2.0f;
    public float wiggleHeight = 0.1f;
	public GameObject head;
	Vector3 headStartSize;

    Vector3 startPosition;
    Vector3 stopPosition;



	// Use this for initialization
	void Start () {
		headStartSize = head.transform.localScale;
		head.GetComponent<MeshRenderer> ().enabled = false;
        startPosition = start.transform.position;
        stopPosition = stop.transform.position;
	}
	
	// Update is called once per frame
	void Update () {

		if (Time.time > startTime) {
			//be visible
			actualMesh.GetComponent<MeshRenderer>().enabled = true;
		}else{
			//don't be visible
			actualMesh.GetComponent<MeshRenderer>().enabled = false;
		}

		if (Time.time > startTime & Time.time<bounceStartTime) {
			float timeAlongPath = Time.time - startTime;
			timeAlongPath = Mathf.Min (timeAlongPath, speed);

			Vector3 line = stop.transform.position - start.transform.position;
			Vector3 direction = line.normalized;

			gameObject.transform.position = start.transform.position + direction* timeAlongPath/speed * line.magnitude ;

		}


		//bouncing:
		if (Time.time > bounceStartTime) {
		
			//bounce based on cosine

			float displacement = 0.5f;
			displacement = wiggleHeight*Mathf.Sin(Time.time);			
			gameObject.transform.position = stop.transform.position + new Vector3(0.0f, displacement, 0.0f);
		
		
		}

		//breathing
		if (Time.time > breathStartTime) {

			float displacement = 0.5f;
			displacement = Mathf.Sin(Time.time);	
			head.transform.localScale = headStartSize * displacement;		
			head.GetComponent<MeshRenderer> ().enabled = true;


		}

	}
}
