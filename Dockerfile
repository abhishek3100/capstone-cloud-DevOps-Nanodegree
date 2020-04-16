FROM nginx

#Removing pre loaded homepage
RUN rm /usr/share/nginx/html/index.html

#Copying our page
COPY index.html /usr/share/nginx/html