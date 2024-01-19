using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class pathFinder : MonoBehaviour
{

    public List<GameObject> path;
    public GameObject start;
    public GameObject destination;
    public float[] Euristiche;
    public GameObject point;
    public int count=0; 

    // Start is called before the first frame update
    void Start()
    {        
       
        GameObject.Find("MovementManager").GetComponent<MovementOnPress>().pathPoints = path;
    }

     
    public void iterativeDeepeningA(GameObject point, GameObject Adestination)
    {
        path.Add(point);
        float bound = euristica(point);

        while (true)
        {         
            float t = searchPath(path, 0, bound);
            if (t==-1) {
           
                break;
            }
            if(t==float.MaxValue)
            {
             
                break;
            } 
            bound = t;
             
        }
        return;
    }

    float searchPath(List<GameObject> apath, float g, float bound)
    {        
       
        GameObject node = apath[path.Count - 1];

        float f = g + euristica(node);
       // Debug.Log(euristica(node));
    
        if (f > bound) return f;
      
        if(node==destination) return -1;
        
        float min = float.MaxValue;
      
        foreach (GameObject vicino in node.GetComponent<CheckpointData>().nodiConnessi)
        {
            if(!apath.Contains(vicino))
            {
                apath.Add(vicino);
                
                float t = searchPath(apath, g + getDistance(node, vicino), bound);
               
                foreach (GameObject nodo in apath)
                {
                    Debug.Log(nodo.GetComponent<CheckpointData>().nome);
                }
                count++;
                if (t == -1) return t;
                if (t < min) min = t;
                apath.RemoveAt(apath.Count - 1);
            }
            
        }

        return min;        
    }

    float getDistance(GameObject point1, GameObject point2){

        Vector3 difference = new Vector3(
                             point1.transform.position.x - point2.transform.position.x,
                             point1.transform.position.y - point2.transform.position.y,
                             point1.transform.position.z - point2.transform.position.z);

                             
        float distance =(float) Math.Sqrt(
        Math.Pow(difference.x, 2f) +
        Math.Pow(difference.y, 2f) +
        Math.Pow(difference.z, 2f));
        return distance;
    }

    float euristica(GameObject point){

        Vector3 difference = new Vector3(
                             point.transform.position.x - destination.transform.position.x,
                             point.transform.position.y - destination.transform.position.y,
                             point.transform.position.z - destination.transform.position.z);

                             
        float distance =(float) Math.Sqrt(
        Math.Pow(difference.x, 2f) +
        Math.Pow(difference.y, 2f) +
        Math.Pow(difference.z, 2f));

        return distance;
    }
}
