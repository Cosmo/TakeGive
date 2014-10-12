using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// The Blank Page item template is documented at http://go.microsoft.com/fwlink/?LinkID=390556

namespace TakeGive.App.WindowsPhone
{
    using System.Threading.Tasks;

    using Windows.Storage;
    using Windows.Storage.Pickers;

    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class GivePage : Page
    {
        public GivePage()
        {
            this.InitializeComponent();
        }

        /// <summary>
        /// Invoked when this page is about to be displayed in a Frame.
        /// </summary>
        /// <param name="e">Event data that describes how this page was reached.
        /// This parameter is typically used to configure the page.</param>
        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
        }

        private async void SelectPictureFromLibrary()
        {
            FileOpenPicker singleFilePicker = new FileOpenPicker();
            singleFilePicker.ViewMode = PickerViewMode.Thumbnail;
            singleFilePicker.SuggestedStartLocation = PickerLocationId.PicturesLibrary;
            singleFilePicker.FileTypeFilter.Add(".jpg");
            singleFilePicker.FileTypeFilter.Add(".jpeg");
            singleFilePicker.FileTypeFilter.Add(".png");
            singleFilePicker.PickSingleFileAndContinue();

            var d = singleFilePicker.ContinuationData;

            //Task.Run(() => singleFilePicker.PickSingleFileAndContinue()).ContinueWith(
            //    task =>
            //        {
            //            StorageFile file = singleFilePicker.;
            //            if (file != null)
            //            {
            //                // We've now got the file. Do something with it.
            //                var stream = await file.OpenAsync(FileAccessMode.Read);
            //                var bitmapImage = new BitmapImage();
            //                await bitmapImage.SetSourceAsync(stream);

            //                var decoder = await BitmapDecoder.CreateAsync(stream);
            //                this.picture.Source = bitmapImage;
            //            }
            //        });
        }

        private void PictureNote_OnClick(object sender, RoutedEventArgs e)
        {
            this.SelectPictureFromLibrary();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Frame.GoBack();
        }
    }
}
