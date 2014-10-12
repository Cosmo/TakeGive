// The Blank Page item template is documented at http://go.microsoft.com/fwlink/?LinkId=391641

namespace TakeGive.App.WindowsPhone
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net.Http;

    using Newtonsoft.Json;

    using Windows.Devices.Geolocation;
    using Windows.UI.Xaml;
    using Windows.UI.Xaml.Controls;
    using Windows.UI.Xaml.Controls.Maps;
    using Windows.UI.Xaml.Navigation;

    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class MainPage : Page
    {
        public MainPage()
        {
            this.InitializeComponent();

            //this.NavigationCacheMode = NavigationCacheMode.Required;
        }

        /// <summary>
        /// Invoked when this page is about to be displayed in a Frame.
        /// </summary>
        /// <param name="e">Event data that describes how this page was reached.
        /// This parameter is typically used to configure the page.</param>
        protected async override void OnNavigatedTo(NavigationEventArgs e)
        {
            // TODO: Prepare page for display here.

            // TODO: If your application contains multiple pages, ensure that you are
            // handling the hardware Back button by registering for the
            // Windows.Phone.UI.Input.HardwareButtons.BackPressed event.
            // If you are using the NavigationHelper provided by some templates,
            // this event is handled for you.

            //this.PopulateMap();

            var geoposition = new BasicGeoposition { Latitude = 52.085395, Longitude = 5.169086 };
            var geopoint = new Geopoint(geoposition);
            
            this.map.MapServiceToken = "AugjVP2kRIkE55ojxklHJJlvfPIK7SA5L0hWhBZnYHiIexWeCDys6Zcbk-zdDPEu";
            this.map.Style = MapStyle.Road;
            
            await this.map.TrySetViewAsync(geopoint, 14D);
        }

        private async void PopulateMap()
        {
            var searchUri = new Uri("http://takegive.mybluemix.net/api/find/bybox?f=" );

            var client = new HttpClient();
            var json = await client.GetStringAsync(searchUri);

            var results = JsonConvert.DeserializeObject<IEnumerable<ItemDto>>(json);
            if (results == null || !results.Any()) return;
            
            foreach (var result in results)
            {
                var icon = new MapIcon();
                icon.Location = new Geopoint(new BasicGeoposition()
                {
                    Latitude = result.Location[0],
                    Longitude = result.Location[1]
                });
                icon.Title = result.Name;
                this.map.MapElements.Add(icon);
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Frame.Navigate(typeof(GivePage));
        }

        private async void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var searchUri = new Uri("http://takegive.mybluemix.net/api/find/byquery?q=" + this.searchbox.Text);

            var client = new HttpClient();
            var json = await client.GetStringAsync(searchUri);

            var results = JsonConvert.DeserializeObject<IEnumerable<ItemDto>>(json);
            if (results == null || !results.Any()) return;

            foreach (var result in results)
            {
                var icon = new MapIcon();
                icon.Location = new Geopoint(new BasicGeoposition()
                {
                    Latitude = result.Location[0],
                    Longitude = result.Location[1]
                });
                icon.Title = result.Name;

                this.map.MapElements.Add(icon);
            }
        }
    }
}
