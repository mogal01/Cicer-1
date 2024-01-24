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
            nascondirenderer(piani0);
            nascondirenderer(piani1);
            nascondirenderer(piani2);
            nascondirenderer(piani3);


        }
        if (player.transform.position.y >-5.75 && player.transform.position.y <= -4.75)
        {
            attivarenderer(piani0);
            nascondirenderer(piani1);
            nascondirenderer(piani2);
            nascondirenderer(piani3);

        }
        if (player.transform.position.y > -4.75 && player.transform.position.y <= -3.5)
        {
            attivarenderer(piani0);
            attivarenderer(piani1);
            nascondirenderer(piani2);
            nascondirenderer(piani3);

        }
        if (player.transform.position.y > -3.5 && player.transform.position.y <= -2.4)
        {
            attivarenderer(piani0);
            attivarenderer(piani1);
            attivarenderer(piani2);
            nascondirenderer(piani3);

        }
        if (player.transform.position.y > 2.4)
        {
            attivarenderer(piani0);
            attivarenderer(piani1);
            attivarenderer(piani2);
            attivarenderer(piani3);

        }
    }


    private void nascondirenderer(GameObject piano)
    {
        MeshRenderer renderer = piano.GetComponent<MeshRenderer>();
        if (renderer != null)
        {
            renderer.enabled = false;
        }
        foreach (Transform child in piano.transform)
        {
            nascondirenderer(child.gameObject);
        }
    }
    private void attivarenderer(GameObject piano)
    {
        MeshRenderer renderer = piano.GetComponent<MeshRenderer>();
        if (renderer != null)
        {
            renderer.enabled = true;
        }
        foreach (Transform child in piano.transform)
        {
            attivarenderer(child.gameObject);
        }
    }
}
