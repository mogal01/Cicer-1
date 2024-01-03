using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{

    public GameObject obj;
    public GameObject[] pathPoints;
    public int numberOfPoints;
    public float speed;


    private Vector3 actualPosition;
    private int x;



    private Vector3 currentAngle;


    // Start is called before the first frame update
    void Start()
    {
        x=0;
        currentAngle = obj.transform.eulerAngles;
    }

    // Update is called once per frame
    void Update()
    {
        actualPosition=obj.transform.position;
        obj.transform.position=Vector3.MoveTowards(actualPosition, pathPoints[x].transform.position, speed * Time.deltaTime);
        //obj.transform.LookAt(pathPoints[x].transform);
        if(actualPosition == pathPoints[x].transform.position && x!= numberOfPoints-1)
        {
            x++;
        }
        if(x == numberOfPoints-1 && actualPosition == pathPoints[x].transform.position)
        x=0;
            // Calcola la rotazione desiderata
            Quaternion desiredRotation = Quaternion.LookRotation(pathPoints[x].transform.position - obj.transform.position);

            // Interpola tra la rotazione corrente e quella desiderata nel tempo
            obj.transform.rotation = Quaternion.Lerp(obj.transform.rotation, desiredRotation, Time.deltaTime * 2.0f);
        
    }


}
