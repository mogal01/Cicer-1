using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestFIA1 : MonoBehaviour
{

    public GameObject Avatar;
    public GameObject Destination;
    public List<GameObject> allPoints;
    public GameObject[] pathPoints;
    public List<GameObject> path;
    public float[] euristiche;
    public int numberOfPoints;
    public float speed;


    private Vector3 actualPosition;
    private int x;



    private Vector3 currentAngle;


    // Start is called before the first frame update
    void Start()
    {
        int i = 0;
        x = 0;
        currentAngle = Avatar.transform.eulerAngles;
        foreach (GameObject point in allPoints)
        {
            euristiche[i] = Euristica(Avatar, point);
            Debug.Log(euristiche[i] + "porcopino");
            i++;
        }
    }


    // Update is called once per frame
    void Update()
    {
        SearchPath(allPoints[0], Destination);
        actualPosition = Avatar.transform.position;
        Avatar.transform.position = Vector3.MoveTowards(actualPosition, path[x].transform.position, speed * Time.deltaTime);
        //obj.transform.LookAt(pathPoints[x].transform);
        if (actualPosition == path[x].transform.position && x != numberOfPoints - 1)
        {
            x++;
        }
        if (x == numberOfPoints - 1 && actualPosition == path[x].transform.position)
            x = 0;
        // Calcola la rotazione desiderata
        Quaternion desiredRotation = Quaternion.LookRotation(path[x].transform.position - Avatar.transform.position);

        // Interpola tra la rotazione corrente e quella desiderata nel tempo
        Avatar.transform.rotation = Quaternion.Lerp(Avatar.transform.rotation, desiredRotation, Time.deltaTime * 2.0f);

    }

    float Euristica(GameObject node, GameObject destination)
    {
        Vector3 difference = new Vector3(
                              destination.transform.position.x - node.transform.position.x,
                              destination.transform.position.y - node.transform.position.y,
                              destination.transform.position.z - node.transform.position.z);

        float distance = (float)Math.Sqrt(
                      Math.Pow(difference.x, 2f) +
                      Math.Pow(difference.y, 2f) +
                      Math.Pow(difference.z, 2f));

        return distance;
    }




    void SearchPath(GameObject start, GameObject goal)
    {
        float initialCost = Euristica(Avatar, Destination);
        float threshold = initialCost;

        while (true)
        {
            float result = IDAStarSearch(start, goal, 0, threshold);

            if (result == float.MaxValue)
            {
                // No path found
                break;
            }

            if (result < 0)
            {
                // Path found
                break;
            }

            // Increase the threshold for the next iteration
            threshold = result;
        }
    }

    float IDAStarSearch(GameObject current, GameObject goal, float g, float threshold)
    {
        Debug.Log(allPoints.IndexOf(current));
        float h = euristiche[allPoints.IndexOf(current)];
        float f = g + h;

        if (f > threshold)
        {
            return f;
        }

        if (current.transform.position == goal.transform.position)
        {
            // Goal reached
            return -1f; // Negative value indicates goal found
        }

        float minCost = float.MaxValue;

        foreach (GameObject neighbor in GetNeighbors(current.transform.position))
        {
            float neighborCost = IDAStarSearch(neighbor, goal, g + 1, threshold);

            if (neighborCost < 0)
            {
                // Goal found in the child node
                path.Add(neighbor);
                return -1f;
            }

            if (neighborCost < minCost)
            {
                minCost = neighborCost;
            }
        }

        return minCost;
    }



    int GetIndexOfPoint(Vector3 point)
    {

        foreach (GameObject pointed in allPoints)
        {
            if (pointed.transform.position == point)
            {
                return allPoints.IndexOf(pointed);
            }
        }
        return -1;
    }

    List<GameObject> GetNeighbors(Vector3 position)
    {
        // Replace this with your logic to get neighboring points
        // This could involve checking adjacency in your 'allPoints' array
        List<GameObject> neighbors = new List<GameObject>();
        // Example: check allPoints array for neighbors within a certain distance
        foreach (GameObject point in allPoints)
        {
            if (Vector3.Distance(position, point.transform.position) < 1.0f)
            {
                neighbors.Add(point);
            }
        }
        return neighbors;
    }


}
