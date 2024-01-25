using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Networking;

public class MainMenuNavigate : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject start;
    public GameObject tipoRicerca;    
    public GameObject menuricercadestinazione;
    public GameObject menuricercaevento;
    public GameObject cambiaavatar;
    public GameObject tornaindietro;
    public GameObject tipoDestinazione;     

    public GameObject searchManagerEvento;
    public GameObject searchManagerDestinazione;
   
    void Start()
    {
        if (PlayerPrefs.GetInt("ChangeForItinerario") == 1)
        {
            PlayerPrefs.SetInt("ChangeForItinerario", 0);
            GameObject.Find("MenuControl").GetComponent<MainMenuNavigate>().PressRicercaDestinazione();
         
            start.SetActive(false);
            cambiaavatar.SetActive(false);
            tornaindietro.SetActive(true);
        }
    }

    public void PressStart()
    {
        tipoRicerca.SetActive(true);        
        start.SetActive(false);
        cambiaavatar.SetActive(false);
        tornaindietro.SetActive(true);

    }

    public void PressRicercaDestinazione()
    {
        tipoRicerca.SetActive(false);              
        tipoDestinazione.SetActive(true);

    }

    public void PressRicercaAula()
    {      
        tipoDestinazione.SetActive(false);
        menuricercadestinazione.SetActive(true);
        searchManagerDestinazione.GetComponent<DestinazioniListManager>().popolaListaDestinazioni("aula");

    }

    public void PressRicercaRistoro()
    {        
        tipoDestinazione.SetActive(false);
        menuricercadestinazione.SetActive(true);
        searchManagerDestinazione.GetComponent<DestinazioniListManager>().popolaListaDestinazioni("ristoro");

    }

    public void PressRicercaUfficio()
    {        
        tipoDestinazione.SetActive(false);
        menuricercadestinazione.SetActive(true);
        searchManagerDestinazione.GetComponent<DestinazioniListManager>().popolaListaDestinazioni("ufficio");

    }

    public void PressRicercaEvento()
    {
        tipoRicerca.SetActive(false);        
        menuricercaevento.SetActive(true);
        searchManagerEvento.GetComponent<EventiListManager>().popolaListaEventi();
    }

 

    public void PressIndietro()
    {
        SceneManager.LoadScene("MainMenu");
    }

    public void TestScena()
    {
        SceneManager.LoadScene("NavigationScene");
    }

}
