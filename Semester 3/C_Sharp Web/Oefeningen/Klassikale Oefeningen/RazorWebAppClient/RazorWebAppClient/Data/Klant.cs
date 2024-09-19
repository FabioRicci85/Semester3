namespace RazorWebAppClient.Data
{
    public class Klant
    {
        public int KlantId { get; set; }
        public string KlantNaam { get; set; }
        public bool GevalideerdeKlant => (KlantId > -1);

        public Klant()
        {
            KlantId = -1;
            KlantNaam = string.Empty;
        }

        public Klant(int id, string naam)
        {
            KlantId = id;
            KlantNaam = naam;
        }
    }
}
