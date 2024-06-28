using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ApriPaginaEvento : MonoBehaviour
{
    public GameObject ricercaEvento;
    public GameObject paginaEvento;
    public GameObject paginaDestinazione;
    // Start is called before the first frame update
    public void apriPaginaEvento()
    {
        ricercaEvento.SetActive(false);
        paginaDestinazione.SetActive(false);
        paginaEvento.SetActive(true);
    }
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
