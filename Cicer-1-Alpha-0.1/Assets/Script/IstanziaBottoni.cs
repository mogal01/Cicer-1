using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class IstanziaBottoni : MonoBehaviour
{
    public Button prefabBottone;
    public Transform parent;

    private Vector3 desiredScale = new Vector3(1f, 1f, 1f);
    // Start is called before the first frame update
    void Start()
    {
     
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void istanzia(string nome)
    {
        Button instance = Instantiate(prefabBottone);
        instance.transform.SetParent(parent);
        instance.transform.localScale = desiredScale;
        instance.transform.localPosition = Vector3.zero;
       // instance.onClick.AddListener(SearchManager.palle);
    }
}
