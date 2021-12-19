from tempfile import NamedTemporaryFile
from os import environ
import dropbox


dbx = dropbox.Dropbox(environ.get("dropboxtoken"))

def DeleteImage(name:str):
    dbx.files_delete('/Pulperia/Products/{0}'.format(name))

def UploadImage(path:str, name:str):
    #listando archivos existentes
    files = []
    for res in dbx.files_list_folder(path='/Pulperia/Products').entries:
        files.append(res.name)

    #generate name unique
    tf = NamedTemporaryFile()
    newfileName = tf.name.split(
        '/')[-1].replace('tmp', '') + "." + name.split('.')[-1]
    while newfileName in files:
        tf = NamedTemporaryFile()
        newfileName = tf.name.split(
        '/')[-1].replace('tmp', '') + "." + name.split('.')[-1]
    
    #upload file
    bath = '/Pulperia/Products/{0}'.format(newfileName)
    dbx.files_upload(open(path, 'rb').read(), bath)
    link:str = dbx.sharing_create_shared_link(path=bath, short_url=False, pending_upload=None).url

    link = link.replace('https://www.dropbox.com/', 'https://dl.dropboxusercontent.com/')
    return {
        'link': link,
        'cloudfilename': newfileName,
    }