using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEditor.Experimental.GraphView;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ApriPaginaDestinazione : MonoBehaviour
{
    public GameObject ricercaDestinazione;
    public GameObject paginaDestinazione;
    public GameObject paginaEvento;
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


    public void iniziaNavigazione()
    {
        string nomeDestinazione=paginaDestinazione.transform.GetChild(1).GetComponent<TMP_Text>().text;
        if (PlayerPrefs.GetInt("SecondDestination") == 1)
        {
            Debug.Log("ECCCOMI 35 APRIPAGINADESTINAZIONE");
            PlayerPrefs.SetString("destinazione2", nomeDestinazione);
            PlayerPrefs.SetInt("SecondDestination", 2);
        }
        else
        {
            PlayerPrefs.SetString("destinazione", nomeDestinazione);
        }
        SceneManager.LoadScene("NavigationScene");
       
    }

    public void iniziaNavigazioneDaEvento()
    {
        string nomeDestinazione = paginaEvento.transform.GetChild(4).GetComponent<TMP_Text>().text;
        if (PlayerPrefs.GetInt("SecondDestination") == 1)
        {
            Debug.Log("ECCCOMI 35 APRIPAGINADESTINAZIONE");
            PlayerPrefs.SetString("destinazione2", nomeDestinazione);
            PlayerPrefs.SetInt("SecondDestination", 2);
        }
        else
        {
            PlayerPrefs.SetString("destinazione", nomeDestinazione);
        }
        SceneManager.LoadScene("NavigationScene");

    }


}
