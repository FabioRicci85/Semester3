namespace RazorWebAppClient.Data
{
    public class Locatie
    {
        public int LocatieID { get; set; }
        public int Postcode { get; set; }
        public string Gemeente { get; set; }

        public Locatie(int id, int postcode, string gemeente)
        {
            LocatieID = id;
            Postcode = postcode;
            Gemeente = gemeente;
        }
    }
}
