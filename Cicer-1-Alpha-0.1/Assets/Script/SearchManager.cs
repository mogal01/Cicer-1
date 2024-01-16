using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class SearchManager : MonoBehaviour
{
    public GameObject ContentHolder;
    public GameObject[] Element;
    public GameObject SearchBar;
    public int totalElements;
    // Start is called before the first frame update

    public void popola()
    {
        totalElements = ContentHolder.transform.childCount;

        Element = new GameObject[totalElements];
        for(int i= 0; i < totalElements; i++)
        {
            Element[i] = ContentHolder.transform.GetChild(i).gameObject;
        }
    }
    
    public void Search()
    {
        string SearchText = SearchBar.GetComponent<TMP_InputField>().text;
        int searchTxtLength = SearchText.Length;
        int searchedElements = 0;
        foreach(GameObject ele in Element)
        {
            searchedElements++;
            if (ele.GetComponentInChildren<Text>().text.Length >= searchTxtLength)
            {
                if(ele.GetComponentInChildren<Text>().text.ToLower().Contains(SearchText.ToLower()))
                {
                    ele.SetActive(true);
                }
                else
                {
                    ele.SetActive(false);
                }
            }

        }
    }
    // Update is called once per frame
    
}
