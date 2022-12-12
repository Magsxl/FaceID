#pogram trenujący model na podstawie zdjęć w folderze obrazki
from facenet_pytorch import MTCNN, InceptionResnetV1
import torch
from torchvision import datasets
from torch.utils.data import DataLoader

#inicjacja detekcji twarzy oraz resnet
mtcnn = MTCNN(image_size=240, margin=0, min_face_size=20)
resnet = InceptionResnetV1(pretrained='vggface2').eval()

#baza zdjęć powinna mieć strukture jak poniżej:
#   dataset
#       name1
#           1.jpg
#           2.jpg
#       name2
#           1.jpg
#           2.jpg

dataset=datasets.ImageFolder('obrazki')# ściezka do bazy zdjęć
idx_to_class = {i:c for c,i in dataset.class_to_idx.items()}

def collate_fn(x):
    return x[0]

loader = DataLoader(dataset, collate_fn=collate_fn)

face_list = []#lisa twarzy przyciętych
name_list = []#lista  imion i nazwisk
embedding_list = []

for img, idx in loader:
    face, prob = mtcnn(img, return_prob=True)
    if face is not None and prob>0.95:#jesli twarz zostala wykryta z prawdopodobienstwem ponad 95%
        emb = resnet(face.unsqueeze(0))
        embedding_list.append(emb.detach())#macierz cech z resnet sa przechowywane w liscie
        name_list.append(idx_to_class[idx])

data = [embedding_list, name_list]
torch.save(data, 'baza.pt')