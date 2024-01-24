using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.UI;
using TMPro;
using static DestinazioniListManager;
using UnityEditor.Experimental.GraphView;

[System.Serializable]
public class Destinazione
{
    public int id;
    public string nome;
    public string stato;
    public string tipo;
    public string nomeEd;

}

public class DestinazioniListManager : MonoBehaviour
{
    public Button prefabBottone;
    public Button prefabBottoneEvento;
    public Transform parent;
    public GameObject MenuRicercaDestinazione;
    public GameObject PaginaDestinazione;
   
    public GameObject listaEventiDiDestinazione;


    private Vector3 desiredScale = new Vector3(1f, 1f, 1f);

    public void popolaListaDestinazioni(string tipo)
    {
        Debug.Log("ciao");
        StartCoroutine(GetRequest("http://localhost:8081/Destinazione/GetList/" + tipo + "/"));

    }

    [System.Serializable]
    public class DestinazioniList
    {
        public Destinazione[] destinazioni;
    }

    public DestinazioniList myDestinazioniList = new DestinazioniList();

    IEnumerator GetRequest(string uri)
    {
        UnityWebRequest uwr = UnityWebRequest.Get(uri);
        yield return uwr.SendWebRequest();

        if (uwr.isNetworkError)
        {
            Debug.Log("Error While Sending: " + uwr.error);
        }
        else
        {
            Debug.Log("Received: " + uwr.downloadHandler.text);

            string json = "{\"destinazioni\":" + uwr.downloadHandler.text + "}";

            myDestinazioniList = JsonUtility.FromJson<DestinazioniList>(json);

            foreach (Destinazione destinazione in myDestinazioniList.destinazioni)
            {
               
                Button instance = Instantiate(prefabBottone);
                instance.transform.SetParent(parent);
                instance.transform.localScale = desiredScale;
                instance.transform.localPosition = Vector3.zero;
                instance.transform.GetChild(0).GetComponent<Text>().text = destinazione.nome;
                instance.transform.GetChild(1).GetComponent<Text>().text = "Edificio:" + destinazione.nomeEd;
                //instance.transform.GetChild(0).GetChild(0).GetComponent<Text>().text = destinazione.tipo;
                instance.transform.GetChild(2).GetComponent<Text>().text = destinazione.stato;
                instance.onClick.AddListener(delegate { this.CaricaPaginaDestinazione(destinazione.id,destinazione.nome, destinazione.stato, destinazione.tipo, destinazione.nomeEd); });
               
            }
            this.gameObject.GetComponent<SearchManager>().popola();
        }
    }

    public void CaricaPaginaDestinazione(int id,string nome, string stato, string tipo, string edificio)
    {

        listaEventiDiDestinazione.GetComponent<EventiListManager>().popolaListaSuDestinazione(id);
        Debug.Log("Riga 76: " + nome);
        MenuRicercaDestinazione.SetActive(false);
        PaginaDestinazione.SetActive(true);
        PaginaDestinazione.transform.GetChild(1).GetComponent<TMP_Text>().SetText(nome);
        PaginaDestinazione.transform.GetChild(2).GetChild(3).GetComponent<TMP_Text>().SetText(stato);
        PaginaDestinazione.transform.GetChild(2).GetChild(2).GetComponent<TMP_Text>().SetText(tipo);
        PaginaDestinazione.transform.GetChild(2).GetChild(1).GetComponent<TMP_Text>().SetText(edificio);

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
