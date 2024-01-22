using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;
using System.Text.RegularExpressions;

public class SearchManager : MonoBehaviour
{
    public GameObject ContentHolder;
    public GameObject[] Element;
    public GameObject SearchBar;
    private int totalElements;
    private bool isEmpty;
    public GameObject erroreRicerca;
    public GameObject erroreCarattereSpeciale;
    public GameObject erroreOrario;
    public TMP_Dropdown dp;

    // Start is called before the first frame update

    public void popola()
    {
        totalElements = ContentHolder.transform.childCount;

        Element = new GameObject[totalElements];
        for (int i = 0; i < totalElements; i++)
        {
            Element[i] = ContentHolder.transform.GetChild(i).gameObject;
        }
    }

    public void MainSearchEvent()
    {
        // Ottieni il valore selezionato
        int selectedValue = dp.value;

        // Puoi anche ottenere la stringa del testo selezionato
        string selectedText = dp.options[selectedValue].text;

        // Ora puoi fare qualcosa con il valore selezionato
        Debug.Log("Valore selezionato: " + selectedValue);
        Debug.Log("Testo selezionato: " + selectedText);

        if (selectedText == "Nome")
        {
            SearchByName();
            Debug.Log("Eccomi 43");
        }
        else
            if (selectedText == "Orario")
        {
            SearchByOrario();
            Debug.Log("Eccomi 48");
        }
        else
        {
            SearchByResponsabile();
            Debug.Log("Eccomi 52");
        }



    }

    public void SearchByName()
    {
        isEmpty = true;
        erroreRicerca.SetActive(false);
        erroreCarattereSpeciale.SetActive(false);
        string SearchText = SearchBar.GetComponent<TMP_InputField>().text;
        int searchTxtLength = SearchText.Length;
        int searchedElements = 0;

        Regex regex = new Regex("^[a-zA-Z0-9 ]+$");
        Match match = regex.Match(SearchText);

        if ((!match.Success) && (SearchText!=""))
        {
         
            erroreCarattereSpeciale.SetActive(true);
        } else
        {
            erroreCarattereSpeciale.SetActive(false);
        }
      
            foreach (GameObject ele in Element)
            {
             
                searchedElements++;
                if (ele.GetComponentInChildren<Text>().text.Length >= searchTxtLength)
                {
                    if (ele.GetComponentInChildren<Text>().text.ToLower().Contains(SearchText.ToLower()))
                    {
                        ele.SetActive(true);
                        isEmpty = false;
                    }
                    else
                    {
                        ele.SetActive(false);
                    }

                }
            }
       


        if ((isEmpty) && (erroreCarattereSpeciale.activeSelf == false))
        {

            erroreRicerca.SetActive(true);
        }

    }
    // Update is called once per frame



    public void SearchByOrario()
    {
        isEmpty = true;
        erroreRicerca.SetActive(false);
        erroreOrario.SetActive(false);
        string SearchText = SearchBar.GetComponent<TMP_InputField>().text;
        int searchTxtLength = SearchText.Length;
        int searchedElements = 0;


        Regex regex = new Regex("^[0-9: ]+$");
        Match match = regex.Match(SearchText);

        if ((!match.Success) && (SearchText != ""))
        {
            erroreOrario.SetActive(true);
        }
        else
        {
            erroreOrario.SetActive(false);
        }

     
            foreach (GameObject ele in Element)
            {
       
                string orario = ele.transform.GetChild(2).GetComponentInChildren<Text>().text.Substring(11);
                searchedElements++;
                if (orario.Length >= searchTxtLength)
                {
                    if (orario.ToLower().Contains(SearchText.ToLower()))
                    {
                        ele.SetActive(true);
                        isEmpty = false;
                    }
                    else
                    {
                        ele.SetActive(false);
                    }

                }
            }
       

        if ((isEmpty) && (erroreOrario.activeSelf == false))
        {

            erroreRicerca.SetActive(true);
        }

    }


    public void SearchByResponsabile()
    {
        isEmpty = true;
        erroreRicerca.SetActive(false);
        erroreCarattereSpeciale.SetActive(false);
        string SearchText = SearchBar.GetComponent<TMP_InputField>().text;
        int searchTxtLength = SearchText.Length;
        int searchedElements = 0;

        Regex regex = new Regex("^[a-zA-Z0-9 ]+$");
        Match match = regex.Match(SearchText);

        if ((!match.Success) && (SearchText != ""))
        {
            erroreCarattereSpeciale.SetActive(true);
        } else
        {
            erroreCarattereSpeciale.SetActive(false);
        }

        foreach (GameObject ele in Element)
        {
            string responsabile = ele.transform.GetChild(1).GetComponentInChildren<Text>().text;
            searchedElements++;
            if (responsabile.Length >= searchTxtLength)
            {
                if (responsabile.ToLower().Contains(SearchText.ToLower()))
                {
                    ele.SetActive(true);
                    isEmpty = false;
                }
                else
                {
                    ele.SetActive(false);
                }

            }
        }

        if ((isEmpty) && (erroreCarattereSpeciale.activeSelf == false))
        {

            erroreRicerca.SetActive(true);
        }

    }
}