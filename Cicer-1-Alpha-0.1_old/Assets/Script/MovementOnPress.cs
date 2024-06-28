using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class MovementOnPress : MonoBehaviour
{

    public GameObject obj;
    public List<GameObject> pathPoints;
    public GameObject destinazionetrovata;
    //public int numberOfPoints;
    public float speed;

    private bool toNext = false;


    public GameObject GruppoCheckpoints;
    private Vector3 actualPosition;
    private int x;
    



    private Vector3 currentAngle;


    // Start is called before the first frame update
    void Start()
    {
  
        x = 0;
      
        currentAngle = obj.transform.eulerAngles;
        toNext = false;
      
    }

    public void parti()
    {
        toNext = true;
    }

    // Update is called once per frame
    void Update()
    {

        if (pathPoints.Count > 0)
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
                else if(actualPosition == pathPoints[x].transform.position && x == pathPoints.Count - 1) 
                {
                    if (PlayerPrefs.GetInt("SecondDestination") == 2)
                    {
                        PlayerPrefs.SetInt("SecondDestination", 0);
                        string destinazioneNuova=PlayerPrefs.GetString("destinazione2");
                        obj.transform.position = pathPoints[x].transform.position;
                        Debug.Log("RIGA 71:" + destinazioneNuova);
                        GruppoCheckpoints.GetComponent<pathFinder>().setDestination(GameObject.Find(destinazioneNuova));
                        GameObject start = pathPoints[x];
                        for(int i = pathPoints.Count-1; i > 0; i--)
                        {
                            pathPoints.Remove(pathPoints[i]);
                        }
                        pathPoints.Remove(pathPoints[0]);
                        Debug.Log("x vale:" + x);
                        x = 1;
                        GruppoCheckpoints.GetComponent<pathFinder>().iterativeDeepeningA(start, GameObject.Find(destinazioneNuova));
                        if(x+1 < pathPoints.Count)
                         x++;
                        toNext = false;
                    }
                    
                }
                if(x==pathPoints.Count - 1 && actualPosition == pathPoints[x].transform.position && PlayerPrefs.GetInt("SecondDestination") == 0)
                {
                
                    destinazionetrovata.SetActive(true);
                }



            }
            // Calcola la rotazione desiderata
            if (pathPoints[x].transform.position - obj.transform.position != Vector3.zero)
            {
                Quaternion desiredRotation = Quaternion.LookRotation(pathPoints[x].transform.position - obj.transform.position);


                // Interpola tra la rotazione corrente e quella desiderata nel tempo
                obj.transform.rotation = Quaternion.Lerp(obj.transform.rotation, desiredRotation, Time.deltaTime * 2.0f);
            }
        }
        
    }


}

