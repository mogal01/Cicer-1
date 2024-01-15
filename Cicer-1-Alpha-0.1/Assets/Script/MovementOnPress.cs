using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class MovementOnPress : MonoBehaviour
{

    public GameObject obj;
    public List<GameObject> pathPoints;
    //public int numberOfPoints;
    public float speed;

    private bool toNext;

    

    private Vector3 actualPosition;
    private int x;
    



    private Vector3 currentAngle;


    // Start is called before the first frame update
    void Start()
    {
        /*x = 0;
        numberOfPoints = 0;
        currentAngle = obj.transform.eulerAngles;
        toNext = false;
        for(int i=1; i < 17; i++)
        {
            pathPoints.Add(GameObject.Find("Checkpoint (" + i + ")"));
            numberOfPoints++;
        }*/
    }

   public void toNextPositive()
    {
        toNext = true;
    }

    // Update is called once per frame
    void Update()
    {
       

        if (toNext)
        {
            
            actualPosition = obj.transform.position;
            obj.transform.position = Vector3.MoveTowards(actualPosition, pathPoints[x].transform.position, speed * Time.deltaTime);
            //obj.transform.LookAt(pathPoints[x].transform);
            if (actualPosition == pathPoints[x].transform.position && x != pathPoints.Count - 1)
            {
                x++;
                toNext = false;
         
            }
            //Vector3 tempVector = obj.transform.position;
            //tempVector.y = (float)-8.5;
            //obj.transform.position = tempVector;
            

           
        }
            // Calcola la rotazione desiderata
            Quaternion desiredRotation = Quaternion.LookRotation(pathPoints[x].transform.position - obj.transform.position);
        
            // Interpola tra la rotazione corrente e quella desiderata nel tempo
            obj.transform.rotation = Quaternion.Lerp(obj.transform.rotation, desiredRotation, Time.deltaTime * 2.0f);
        
    }


}

