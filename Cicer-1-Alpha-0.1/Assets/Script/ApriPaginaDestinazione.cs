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
        PlayerPrefs.SetString("destinazione", nomeDestinazione);
        SceneManager.LoadScene("NavigationScene");
       
    }
}
