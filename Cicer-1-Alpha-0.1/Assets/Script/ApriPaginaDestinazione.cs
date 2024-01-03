using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ApriPaginaDestinazione : MonoBehaviour
{
    public GameObject ricercaDestinazione;
    public GameObject paginaDestinazione;
    // Start is called before the first frame update
    public void apriPaginaDestinazione()
    {
        ricercaDestinazione.SetActive(false);
        paginaDestinazione.SetActive(true);
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
