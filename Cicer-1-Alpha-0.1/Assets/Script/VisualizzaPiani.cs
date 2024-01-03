using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VisualizzaPiani : MonoBehaviour
{
    public GameObject player;
    public GameObject piani0;
    public GameObject piani1;
    public GameObject piani2;
    public GameObject piani3;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (player.transform.position.y <= -5.75)
        {
            piani0.SetActive(false);
            piani1.SetActive(false);
            piani2.SetActive(false);
            piani3.SetActive(false);

        }
        if (player.transform.position.y >-5.75 && player.transform.position.y <= -4.75)
        {
            piani0.SetActive(true);
            piani1.SetActive(false);
            piani2.SetActive(false);
            piani3.SetActive(false);

        }
        if (player.transform.position.y > -4.75 && player.transform.position.y <= -3.5)
        {
            piani0.SetActive(true);
            piani1.SetActive(true);
            piani2.SetActive(false);
            piani3.SetActive(false);

        }
        if (player.transform.position.y > -3.5 && player.transform.position.y <= -2.4)
        {
            piani0.SetActive(true);
            piani1.SetActive(true);
            piani2.SetActive(true);
            piani3.SetActive(false);

        }
        if (player.transform.position.y > 2.4)
        {
            piani0.SetActive(true);
            piani1.SetActive(true);
            piani2.SetActive(true);
            piani3.SetActive(true);

        }
    }
}
