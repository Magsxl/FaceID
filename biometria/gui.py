from facenet_pytorch import MTCNN, InceptionResnetV1
import torch
import PIL.Image

from kivy.app import App
from kivy.properties import StringProperty, ObjectProperty
from kivy.uix.floatlayout import FloatLayout
from kivy.lang import Builder
from kivy.core.window import Window
from kivy.uix.popup import Popup
from kivy.uix.video import Video, Image

#inicjacja detekcji twarzy oraz resnet
mtcnn = MTCNN(image_size=240, margin=0, min_face_size=20)
resnet = InceptionResnetV1(pretrained='vggface2').eval()

Builder.load_file('GUI.kv')

class Image(Image):
    pass

class File(Popup):#eksplorator plików
    load = ObjectProperty()

class MyLayout(FloatLayout):
    file_path = StringProperty("No file chosen")
    the_popup = ObjectProperty(None)


    def open_popup(self):
        self.the_popup = File(load=self.load)
        self.the_popup.open()
        self.ids.face_name.text = ""
        self.ids.my_image.source = ""

    def load(self, selection):
        self.file_path = str(selection[0])
        self.the_popup.dismiss()

        if self.file_path:
            self.ids.my_image.source = self.file_path

    def start(self):#funkcja poruwnująca róznice cech załadowanego zdjęcia z tymi w bazie
        img = PIL.Image.open(self.file_path)
        face, prob = mtcnn(img, return_prob=True)
        emb = resnet(face.unsqueeze(0)).detach()

        saved_data = torch.load('baza.pt')
        embedding = saved_data[0] #lista chech
        name = saved_data[1] #lista imion i nazwisk
        dist_list = []#  lista

        for idx, emb_db in enumerate(embedding):
            dist = torch.dist(emb, emb_db).item()
            dist_list.append(dist)

        idx_min = dist_list.index(min(dist_list))
        result = (name[idx_min], min(dist_list))
        #zmiana labela na imie i nazwisko osoby na zdjeciu

        #identyfikacja tożsamości na podsawie wyuczonej bazy
        if(result[1]>1):
            self.ids.face_name.text = "Nie ma takiej osoby w bazie"
        else:
            self.ids.face_name.text = result[0]

        #opcja do smany systemu w system weryfikacji tozsamości
        #if(result[0] == "Mateusz Bartoszewicz"):
        #    self.ids.face_name.text = "Otyrzymujesz dostep"
        #else:
        #    self.ids.face_name.text = "Brak dostepu"


class App(App):
    def build(self):
        Window.clearcolor = (0,0,0,0)
        return MyLayout()


if __name__ == '__main__':
    App().run()
