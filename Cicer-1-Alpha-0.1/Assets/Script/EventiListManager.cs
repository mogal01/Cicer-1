using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.UI;
using TMPro;

[System.Serializable]
public class Evento
{
    public int id;
    public string nome ;
    public string data_ora_inizio;
    public string data_ora_fine; 
    public string tipo ; 
    public string destinazione; 
    public string utente; 
    public string responsabile;
}

public class EventiListManager : MonoBehaviour
{
    public Button prefabBottone;
    public Transform parent;
    public GameObject MenuRicercaEvento;
    public GameObject PaginaEvento;

    private Vector3 desiredScale = new Vector3(1f, 1f, 1f);

    public void popolaListaEventi()
    {  
        Debug.Log("ciao");
        StartCoroutine(GetRequest("http://localhost:8081/Evento/GetList/"));        
    }

    public void popolaListaSuDestinazione(int destinazione)
    {
        Debug.Log("TEST RIGA 38");
        StartCoroutine(GetRequestForDestination("http://localhost:8081/Evento/GetEventiDestSpec/" + destinazione));

    }

    [System.Serializable]
    public class EventiList
    {
        public Evento[] eventi;
    }

    public EventiList myEventiList = new EventiList();

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
            
            string json = "{\"eventi\":" + uwr.downloadHandler.text + "}";
           
            myEventiList = JsonUtility.FromJson<EventiList>(json);     
            
            foreach(Evento evento in myEventiList.eventi)
            {
                Button instance = Instantiate(prefabBottone);
                instance.transform.SetParent(parent);
                instance.transform.localScale = desiredScale;
                instance.transform.localPosition = Vector3.zero;
                instance.transform.GetChild(0).GetComponent<Text>().text = evento.nome;
                instance.transform.GetChild(1).GetComponent<Text>().text = evento.responsabile;
                instance.transform.GetChild(2).GetComponent<Text>().text = evento.data_ora_inizio;
                instance.onClick.AddListener(delegate {this.CaricaPaginaEvento(evento.nome, evento.data_ora_inizio, evento.destinazione, evento.responsabile); });
            }
            this.gameObject.GetComponent<SearchManager>().popola();
        }
    }


    IEnumerator GetRequestForDestination(string uri)
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

            string json = "{\"eventi\":" + uwr.downloadHandler.text + "}";

            myEventiList = JsonUtility.FromJson<EventiList>(json);

            foreach (Evento evento in myEventiList.eventi)
            {
                Button instance = Instantiate(prefabBottone);
                instance.transform.SetParent(parent);
                instance.transform.localScale = desiredScale;
                // Assumi che instance sia il tuo bottone con un RectTransform
                RectTransform rectTransform = instance.GetComponent<RectTransform>();

                // Per cambiare il left margin
                rectTransform.offsetMin = new Vector2(-210, rectTransform.offsetMin.y);

                // Oppure, se vuoi cambiare la posizione ancorata, che � relativa agli anchor points
                rectTransform.anchoredPosition = new Vector2(-210, rectTransform.anchoredPosition.y);

                instance.transform.GetChild(0).GetComponent<Text>().text = evento.nome;
                instance.transform.GetChild(1).GetComponent<Text>().text = evento.responsabile;
                instance.transform.GetChild(2).GetComponent<Text>().text = evento.data_ora_inizio;
                instance.onClick.AddListener(delegate { this.CaricaPaginaEvento(evento.nome, evento.data_ora_inizio, evento.destinazione, evento.responsabile); });
            }
            this.gameObject.GetComponent<SearchManager>().popola();
        }
    }

    public void CaricaPaginaEvento(string nome, string data_ora_inizio, string destinazione, string responsabile)
    {
        Debug.Log(nome);
        MenuRicercaEvento.SetActive(false);
        PaginaEvento.SetActive(true);
        PaginaEvento.transform.GetChild(2).GetComponent<TMP_Text>().SetText(nome);
        PaginaEvento.transform.GetChild(3).GetComponent<TMP_Text>().SetText(data_ora_inizio);
        PaginaEvento.transform.GetChild(4).GetComponent<TMP_Text>().SetText(destinazione);        
        PaginaEvento.transform.GetChild(5).GetComponent<TMP_Text>().SetText(responsabile);

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
