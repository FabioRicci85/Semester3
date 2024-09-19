namespace RazorWebAppClient.Data
{
    public class Databank
    {
        public static List<Klant> Klanten { get; set; }
        public static void StartDatabank()
        {
            Klanten = new List<Klant>();
            Klanten.Add(new Klant(1, "Klant A"));
            Klanten.Add(new Klant(2, "Klant B"));

            Locaties = new List<Locatie>();
            Locaties.Add(new Locatie(1, 3500, "Hasselt"));
            Locaties.Add(new Locatie(2, 3600, "Genk"));
        }

        public static List<Locatie> Locaties { get; set; }

    }
}
