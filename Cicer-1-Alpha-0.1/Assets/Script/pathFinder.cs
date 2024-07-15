using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using JetBrains.Annotations;

public class pathFinder : MonoBehaviour
{

    public List<GameObject> path;
    //private GameObject start;
    private GameObject destination;
    public float[] Euristiche;
    public GameObject point;
    public int count=0; 

    // Start is called before the first frame update
    void Start()
    {                
        GameObject.Find("MovementManager").GetComponent<MovementOnPress>().pathPoints = path;
    }

    void ConfigureLineRenderer(LineRenderer lineRenderer)
    {
        lineRenderer.startWidth = 0.05f;
        lineRenderer.endWidth = 0.05f;
        lineRenderer.material = new Material(Shader.Find("Sprites/Default"));
        lineRenderer.startColor = Color.blue;
        lineRenderer.endColor = Color.blue;
    }
    
    public void setDestination(GameObject d)
    {
        destination = d;
    }
     
    public void iterativeDeepeningA(GameObject startingPoint, GameObject Adestination)
    {
        path.Add(startingPoint);
        float bound = euristica(startingPoint);//inizializzazione valore di taglio

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

        //--------------------------------------------------
        GameObject.Find("MovementManager").GetComponent<MovementOnPress>().pathPoints = path;
        
        for (int i = 0; i < path.Count - 1; i++)
        {
            LineRenderer lineRenderer = path[i].AddComponent<LineRenderer>();
            ConfigureLineRenderer(lineRenderer);

            // Imposta i punti della linea
            Vector3[] positions = new Vector3[2];
            positions[0] = path[i].transform.position;
            positions[1] = path[i + 1].transform.position;
            lineRenderer.SetPositions(positions);
        }
    
        return;
    }

    float searchPath(List<GameObject> apath, float g, float bound)
    {               
        GameObject currentNode = apath[path.Count - 1];

        float f = g + euristica(currentNode); //g + euristica(node);
       
        if (f > bound) return f; // restituisce un bound superiore se f > bound
      
        if(currentNode==destination) return -1; // uno dei possibili percorsi trovato
        
        float min = float.MaxValue;
      
        foreach (GameObject vicino in currentNode.GetComponent<CheckpointData>().nodiConnessi)
        {
            if(!apath.Contains(vicino))
            {
                apath.Add(vicino);
                
                float t = searchPath(apath, g + getDistance(currentNode, vicino), bound);

                // restituendo t si ottiene l'arresto della funzione searchPath e il ritorno del percorso trovato
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
        Debug.Log("TEST EURISTICA");
        Debug.Log("point" + point.transform.position.x);
        Debug.Log("Dest" + destination.transform.position.x);

        float primoCateto = (float) point.transform.position.x - destination.transform.position.x;
        
        return Math.Abs(primoCateto) + Math.Abs(point.transform.position.y) + Math.Abs(destination.transform.position.y);
    }
}


