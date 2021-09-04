

👉 Cloud Storage: Qwik Start - CLI/SDK
======================================



### The Google Cloud Shell

### Activate Cloud Shell

Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources.

In the Cloud Console, in the top right toolbar, click the **Activate Cloud Shell** button.

![](https://cdn.qwiklabs.com/vdY5e%2Fan9ZGXw5a%2FZMb1agpXhRGozsOadHURcR8thAQ%3D)



Click **Continue**.

![](https://cdn.qwiklabs.com/lr3PBRjWIrJ%2BMQnE8kCkOnRQQVgJnWSg4UWk16f0s%2FA%3D)

It takes a few moments to provision and connect to the environment. When you are connected, you are already authenticated, and the project is set to your _PROJECT\_ID_. For example:

![](https://cdn.qwiklabs.com/hmMK0W41Txk%2B20bQyuDP9g60vCdBajIS%2B52iI2f4bYk%3D)

`gcloud` is the command-line tool for Google Cloud. It comes pre-installed on Cloud Shell and supports tab-completion.

You can list the active account name with this command:



```bash
gcloud auth list
gcloud config list project
```



![](https://t4668229.p.clickup-attachments.com/t4668229/b23feb1b-89e8-4688-8038-c2be1dfea0d2/image.png)



![](https://t4668229.p.clickup-attachments.com/t4668229/05e7782b-899c-42d8-aeaa-e0ac166fffa7/image.png)



👉 download an image to temporary instance

```bash
wget --output-document ada.jpg https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg
```



👉 copy an image to a bucket

```bash
gsutil cp ada.jpg gs://YOUR-BUCKET-NAME

gsutil cp ada.jpg gs://qwiklabs-gcp-03-c10a58de4694
```



👉 remove downloaded image

```bash
rm ada.jpg
```



👉 download an object from your bucket

```bash
gsutil cp -r gs://YOUR-BUCKET-NAME/ada.jpg .

gsutil cp -r gs://qwiklabs-gcp-03-c10a58de4694/ada.jpg .
```



![](https://t4668229.p.clickup-attachments.com/t4668229/02dfdcee-c1bb-4df6-9a06-058c407db220/image.png)



👉 copy an object to a bucket

```bash
gsutil cp gs://YOUR-BUCKET-NAME/ada.jpg gs://YOUR-BUCKET-NAME/image-folder/

gsutil cp gs://my-bucket/ada.jpg gs://qwiklabs-gcp-03-c10a58de4694/image-folder/
```



![](https://t4668229.p.clickup-attachments.com/t4668229/0debdbaa-217a-4b41-8763-56e27722553f/image.png)



👉 list the contents of a bucket or folder

```bash
gsutil ls gs://YOUR-BUCKET-NAME

gsutil ls gs://qwiklabs-gcp-03-c10a58de4694
```



![](https://t4668229.p.clickup-attachments.com/t4668229/feea2ce1-8254-456a-bedd-af73d7efe2ed/image.png)



👉 list the details of an object

```bash
gsutil ls -l gs://YOUR-BUCKET-NAME/ada.jpg

gsutil ls -l gs://qwiklabs-gcp-03-c10a58de4694/image-folder/ada.jpg
```



![](https://t4668229.p.clickup-attachments.com/t4668229/12b92922-43dd-4336-bcda-29e9beeec9e4/image.png)



👉 make your object publicly accessible

```bash
gsutil acl ch -u AllUsers:R gs://YOUR-BUCKET-NAME/ada.jpg

gsutil acl ch -u AllUsers:R gs://qwiklabs-gcp-03-c10a58de4694/image-folder/ada.jpg
```



![](https://t4668229.p.clickup-attachments.com/t4668229/ce58c111-8ed0-493c-8c4b-290c7b83f01f/image.png)



👉 remove public access

```bash
gsutil acl ch -d AllUsers gs://YOUR-BUCKET-NAME/ada.jpg

gsutil acl ch -d AllUsers gs://qwiklabs-gcp-03-c10a58de4694/image-folder/ada.jpg
```



![](https://t4668229.p.clickup-attachments.com/t4668229/d8dc1a1f-7025-4c42-b66d-9cf8ba355d80/image.png)



👉 delete objects

```bash
gsutil rm gs://YOUR-BUCKET-NAME/ada.jpg

gsutil rm gs://qwiklabs-gcp-03-c10a58de4694/image-folder/ada.jpg
```



![](https://t4668229.p.clickup-attachments.com/t4668229/f4dec797-e2b7-407e-baf4-13cd3ffa751d/image.png)




👓 **Further reference**

https://cloud.google.com/sdk/gcloud

