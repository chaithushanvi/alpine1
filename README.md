Step1: First we need to create one directory in our local for better understand

     * mkdir (dir name)

Step2: We need to clone the gitlab repository

     * git clone -b branchname repo-url

Step3: we need to build an image from the docker file

     * docker build -t (image name) .
     . represents cuurent directory
 
Step4: After creating the docker image we want to create one docker container from the image

     * docker run --name (container name) -td (image name)

Step5: we need to follow the docker logs its shows the magento installation
    
     * docker logs --follow (container_name) 

Step6: once the installation is done you should enter into the container before enter into the container you need to presses ctrlp+ctrlq

     * ctrlp+ctlq 
     
     * docker exec -it (conatiner name) sh

Step7:We need to check  all the ports are running or not
 
    * netstat -tulpn     -- for ports
    
Step8 : After that we need to copy that container ip address

    * hostname -i

Step9: Once  you copy the addresses you need to exit that container without stopping that container

     * (ctrlp+ctrlq)

Step10: Then we need to enter that /etc folder in that folder we found a hosts file there we need to paste the ip addresses overthere

     * vim /etc/hosts

Step11: here we paste the ip addresses with the base url

     * ip address base url (magento2.4.3.com)

     then we need to save that file
      * we need to presss the escape button and press the wq!
      * wq!

Step12:you can enter base url in your search bar 

     * magento2.4.3.com

Step13: if you want admin page you can run below command

     * cd /var/www/html/magento
     in this folder you can run the commond
      
     * php bin/magento info:adminuri

     after that you will get adminuri you need to copy that one and paste the browser 
     there you need to enter the admin creditionals
     username:admin
     password:admin123 
