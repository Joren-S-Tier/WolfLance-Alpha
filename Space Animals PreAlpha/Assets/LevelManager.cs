using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class LevelManager : MonoBehaviour
{
   public void StartGame()
   {
	SceneManager.LoadScene("SpaceAnimalsFirstBuild");
   }

   public void LoadMainMenu()
   {
        SceneManager.LoadScene("mainMenu");
   }

   
   //quits the game
   public void QuitGame()
   {
	Application.Quit();
   }
}
