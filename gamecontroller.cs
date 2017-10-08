using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class gamecontroller : MonoBehaviour {

    public GameObject head;
    public GameObject pinPrefab;
    public GameObject world;

	// Use this for initialization
	void Start () {
		
	}
    public GameObject floor;
    public float newHeight = 2.0f;

    public bool scaling = false;

    Vector3 originalScale;
    float originalMagnitude;

	// Update is called once per frame
	void Update () {

        /*
        for(int i = 0; i<Input.touchCount; i++)
        {
            Touch touch = Input.touches[i];
            if (touch.phase == TouchPhase.Began)
            {
                // Construct a ray from the current touch coordinates
                var ray = head.GetComponent<Camera>().ScreenPointToRay(touch.position);
                RaycastHit hit;

                if (Physics.Raycast(ray, out hit, 1000))
                {
                    if(hit.collider.gameObject.name == "floor")
                    {
                        GameObject pin = GameObject.Instantiate(pinPrefab);
                        pin.transform.position = hit.point;
                    }
                }
            }
        }
        */

        //if(Application.platform != RuntimePlatform.Android)
        //{


        if(Input.touchCount == 2)
        {
            Vector2 touch1 = Input.touches[0].position;
            Vector2 touch2 = Input.touches[1].position;

            if(scaling == false)
            {
                originalMagnitude = (touch1 - touch2).magnitude;
                originalScale = world.transform.localScale;
                scaling = true;
            }
            else
            {
                float val = (touch1 - touch2).magnitude / originalMagnitude;
                world.transform.localScale = val * originalScale;
            }
        }
        else
        {
            scaling = false;

            if (Input.GetMouseButtonDown(0))
            {

                if (EventSystem.current.IsPointerOverGameObject())
                {

                }
                else
                {
                    var ray = head.GetComponent<Camera>().ScreenPointToRay(Input.mousePosition);
                    RaycastHit hit;
                    if (Physics.Raycast(ray, out hit, 1000))
                    {
                        if (hit.collider.gameObject.name == "floor")
                        {
                            GameObject start = new GameObject();
                            GameObject stop = new GameObject();
                            stop.transform.position = hit.point;
                            start.transform.parent = floor.transform;
                            start.transform.position = stop.transform.position;
                            start.transform.position = start.transform.position + new Vector3(0.0f, newHeight, 0.0f);

                            GameObject pin = GameObject.Instantiate(pinPrefab);
                            pin.transform.parent = world.transform;
                            pin.GetComponent<Drop>().start = start;
                            pin.GetComponent<Drop>().stop = stop;

                            pin.transform.position = hit.point;

                            start.transform.parent = world.transform;
                            stop.transform.parent = world.transform;

                            //Debug.Break();

                        }
                    }
                }
            }


        }


            

                
            
        //}


    }

    public float speed = 0.1f;
    public void right()
    {
        //Debug.Log("right!");
        Vector3 angles = world.transform.localEulerAngles;
        angles.y += speed;
        world.transform.localEulerAngles = angles;
    }

    public void left()
    {
        //Debug.Log("left!");
        Vector3 angles = world.transform.localEulerAngles;
        angles.y -= speed;
        world.transform.localEulerAngles = angles;
    }

}
