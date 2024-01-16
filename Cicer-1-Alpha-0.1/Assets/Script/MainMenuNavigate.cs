using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Networking;

public class MainMenuNavigate : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject start;
    public GameObject ricercaevento;
    public GameObject ricercadestinazione;
    public GameObject menuricercadestinazione;
    public GameObject menuricercaevento;
    public GameObject cambiaavatar;
    public GameObject tornaindietro;
    public GameObject ricercaaula;
    public GameObject ricercaristoro;
    public GameObject ricercaufficio;

    public GameObject searchManagerEvento;

    public void PressStart()
    {
        ricercaevento.SetActive(true);
        ricercadestinazione.SetActive(true);
        start.SetActive(false);
        cambiaavatar.SetActive(false);
        tornaindietro.SetActive(true);

    }

    public void PressRicercaDestinazione()
    {
        ricercaevento.SetActive(false);
        ricercadestinazione.SetActive(false);
        ricercaaula.SetActive(true);
        ricercaristoro.SetActive(true);
        ricercaufficio.SetActive(true);

    }

    public void PressRicercaAula()
    {
        ricercaaula.SetActive(false);
        ricercaristoro.SetActive(false);
        ricercaufficio.SetActive(false);
        menuricercadestinazione.SetActive(true);

    }

    public void PressRicercaRistoro()
    {
        ricercaaula.SetActive(false);
        ricercaristoro.SetActive(false);
        ricercaufficio.SetActive(false);
        menuricercadestinazione.SetActive(true);

    }

    public void PressRicercaUfficio()
    {
        ricercaaula.SetActive(false);
        ricercaristoro.SetActive(false);
        ricercaufficio.SetActive(false);
        menuricercadestinazione.SetActive(true);


    }

    public void PressRicercaEvento()
    {
        ricercaevento.SetActive(false);
        ricercadestinazione.SetActive(false);
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
