using UnityEngine;
using UnityEngine.UI;

public class PopolaMenuSceltaPartenza : MonoBehaviour
{
    public GameObject buttonPrefab; // Riferimento al prefab del bottone
    public Transform content; // Riferimento al pannello del menu dove aggiungere i bottoni
    public GameObject menuScegliPartenza;
    public GameObject GruppoCheckpoints;
    public GameObject avatar;
    public GameObject MM;
    private GameObject[] checkpoints;
    public GameObject SceltaPartenzaManager;

    void Start()
    {
        GenerateCheckpointButtons();
    }

    void GenerateCheckpointButtons()
    {
        GameObject[] checkpoints = GameObject.FindGameObjectsWithTag("InitialCheckpoint");

        foreach (GameObject checkpoint in checkpoints)
        {
           
            GameObject buttonObj = Instantiate(buttonPrefab, content);
            buttonObj.GetComponentInChildren<Text>().text = checkpoint.GetComponent<CheckpointData>().nome; // Imposta il testo del bottone
            buttonObj.GetComponent<Button>().onClick.AddListener(() => OnCheckpointSelected(checkpoint));
            Debug.Log("Eccomi 30");


            // Aggiungi qui un listener per l'evento onClick del bottone, se necessario
            // Ad esempio: buttonObj.GetComponent<Button>().onClick.AddListener(() => OnCheckpointSelected(checkpoint));
        }
        SceltaPartenzaManager.GetComponent<SearchManager>().popola();
    }

    public void parti() {
        //MM.GetComponent<MovementOnPress>().parti();

}

    // Esempio di funzione chiamata quando un checkpoint viene selezionato
    void OnCheckpointSelected(GameObject checkpoint)
    {
        Debug.Log("Checkpoint selezionato: " + checkpoint.name);
        //GruppoCheckpoints.GetComponent<pathFinder>().start = checkpoint;
        string destinazione=PlayerPrefs.GetString("destinazione");
        //GruppoCheckpoints.GetComponent<pathFinder>().destination=GameObject.Find(destinazione);
        avatar.transform.position = checkpoint.transform.position;
        GameObject destinazioneVera = GameObject.Find(destinazione);

        GruppoCheckpoints.GetComponent<pathFinder>().setDestination(destinazioneVera);
        GruppoCheckpoints.GetComponent<pathFinder>().iterativeDeepeningA(checkpoint, destinazioneVera);
        menuScegliPartenza.SetActive(false);
        //MM.GetComponent<MovementOnPress>().parti();

    }



}
