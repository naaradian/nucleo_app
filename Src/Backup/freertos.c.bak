/**
  ******************************************************************************
  * File Name          : freertos.c
  * Description        : Code for freertos applications
  ******************************************************************************
  * This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * Copyright (c) 2019 STMicroelectronics International N.V. 
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "FreeRTOS.h"
#include "task.h"
#include "cmsis_os.h"

/* USER CODE BEGIN Includes */     

#include "stm32f4xx_hal.h"
#include "lwip/opt.h"
#include "lwip/arch.h"
#include "lwip/opt.h"
#include "lwip/api.h"
#include "lwip.h"
#include "lwip/inet.h"
#include "lwip/sockets.h"
#include "string.h"
#include "spi.h"
#include "usart.h"
//#include "stm32f4xx_dma.h"
//#include "Trace.h"

#define  MY_UDP_PORT		(7)
/* USER CODE END Includes */

/* Variables -----------------------------------------------------------------*/
osThreadId defaultTaskHandle;
osThreadId myTask02Handle;
osThreadId myTask03Handle;
osSemaphoreId myBinarySem01_SPI1THandle;
osSemaphoreId myBinarySem02_USART2THandle;
osSemaphoreId myBinarySem03_USART2RHandle;

/* USER CODE BEGIN Variables */
//uint8_t testDataToReceiveU[U2_BUFF_SIZE];
//uint16_t u2cnt;
//uint8_t RB;
#define TIME_WAIT_JUMP  (7500)//  (10000)

#define 	NVIC_VectTab_FLASH   ((uint32_t)0x08000000)
typedef  void (*pFunction)(void);
pFunction Jump_To_Application;
uint32_t JumpAddress;
char RcvBuff[RCV_BUFF_SIZE];
char TrBuff[TR_BUFF_SIZE];
unsigned long counter = 0;
//uint8_t flag_rcv = 0;
/* USER CODE END Variables */

/* Function prototypes -------------------------------------------------------*/
void StartDefaultTask(void const * argument);
void StartTask02(void const * argument);
void StartTask03(void const * argument);

extern void MX_USB_DEVICE_Init(void);
extern void MX_LWIP_Init(void);
void MX_FREERTOS_Init(void); /* (MISRA C 2004 rule 8.1) */

/* USER CODE BEGIN FunctionPrototypes */
static void udp_thread(void *arg);
extern uint8_t CDC_Transmit_FS(uint8_t* Buf, uint16_t Len);
//static void udp_thread1(void *arg);
void CheckWriteStorage(void) {
	if(write_cnt) write_cnt--;
	if(write_cnt == 1) WriteStorage();
}
/* USER CODE END FunctionPrototypes */

/* Hook prototypes */

/* Init FreeRTOS */

void MX_FREERTOS_Init(void) {
  /* USER CODE BEGIN Init */
       
  /* USER CODE END Init */

  /* USER CODE BEGIN RTOS_MUTEX */
  /* add mutexes, ... */
  /* USER CODE END RTOS_MUTEX */

  /* Create the semaphores(s) */
  /* definition and creation of myBinarySem01_SPI1T */
  osSemaphoreDef(myBinarySem01_SPI1T);
  myBinarySem01_SPI1THandle = osSemaphoreCreate(osSemaphore(myBinarySem01_SPI1T), 1);

  /* definition and creation of myBinarySem02_USART2T */
  osSemaphoreDef(myBinarySem02_USART2T);
  myBinarySem02_USART2THandle = osSemaphoreCreate(osSemaphore(myBinarySem02_USART2T), 1);

  /* definition and creation of myBinarySem03_USART2R */
  osSemaphoreDef(myBinarySem03_USART2R);
  myBinarySem03_USART2RHandle = osSemaphoreCreate(osSemaphore(myBinarySem03_USART2R), 1);

  /* USER CODE BEGIN RTOS_SEMAPHORES */
  /* add semaphores, ... */
  /* USER CODE END RTOS_SEMAPHORES */

  /* USER CODE BEGIN RTOS_TIMERS */
  /* start timers, add new ones, ... */
  /* USER CODE END RTOS_TIMERS */

  /* Create the thread(s) */
  /* definition and creation of defaultTask */
  osThreadDef(defaultTask, StartDefaultTask, osPriorityNormal, 0, 256);
  defaultTaskHandle = osThreadCreate(osThread(defaultTask), NULL);

  /* definition and creation of myTask02 */
  osThreadDef(myTask02, StartTask02, osPriorityHigh, 0, 128);
  myTask02Handle = osThreadCreate(osThread(myTask02), NULL);

  /* definition and creation of myTask03 */
  osThreadDef(myTask03, StartTask03, osPriorityIdle, 0, 512);
  myTask03Handle = osThreadCreate(osThread(myTask03), NULL);

  /* USER CODE BEGIN RTOS_THREADS */
  /* add threads, ... */
  /* USER CODE END RTOS_THREADS */

  /* USER CODE BEGIN RTOS_QUEUES */
  /* add queues, ... */
  /* USER CODE END RTOS_QUEUES */
}

/* StartDefaultTask function */
void StartDefaultTask(void const * argument)
{
  /* init code for USB_DEVICE */
  MX_USB_DEVICE_Init();

  /* init code for LWIP */
  MX_LWIP_Init();

  /* USER CODE BEGIN StartDefaultTask */
  ReadStorage();  //for have property ip
  My_ChangeIp();  //need add to remote
   //============================
  struct netconn *conn, *newconn;
      err_t err, accept_err;
      struct netbuf* buf;
      void* data;
      u16_t len;
      err_t recv_err;

      sys_thread_new("udp_thread", udp_thread, NULL, DEFAULT_THREAD_STACKSIZE, osPriorityNormal);

  conn = netconn_new(NETCONN_TCP);
    if (conn != NULL)
    {
        /* Bind connection to well known port number 1000. */
        err = netconn_bind(conn, NULL, 1000);

        if (err == ERR_OK)
        {
            /* Tell connection to go into listening mode. */
            netconn_listen(conn);

            while (1)
            {
                /* Grab new connection. */
                accept_err = netconn_accept(conn, &newconn);

                /* Process the new connection. */
                if (accept_err == ERR_OK)
                {
                    while ((recv_err = netconn_recv(newconn, &buf)) == ERR_OK)
                    {
                        do
                        {
                            netbuf_data(buf, &data, &len);
                            netconn_write(newconn, data, len, NETCONN_COPY);

                        } while (netbuf_next(buf) >= 0);

                        netbuf_delete(buf);
                    }   //while recv

                    /* Close connection and discard connection identifier. */
                    netconn_close(newconn);
                    netconn_delete(newconn);
                }  //if accept_err
 //         	  HAL_GPIO_TogglePin( GPIOB, GPIO_PIN_7);
//          	  HAL_Delay(1000);

            } //wile(1)
        } //if err == err_ok
        else
        {
            netconn_delete(newconn);
            printf(" can not bind TCP netconn");
        }
    }  //in conn != NULL
    else
    {
        printf("can not create TCP netconn");
    }
// to end}



  //============================

 /*
    struct netconn * conn, *newconn;
  err_t err, accept_err;
conn = netconn_new(NETCONN_TCP);
  if(conn != NULL) {
	err = netconn_bind(conn, NULL, 1000);
	if(err == ERR_OK) {
    netconn_listen(conn);
    accept_err = netconn_accept(conn, &newconn);
    if(accept_err == ERR_OK) {
    	while(1) {
    		char buffer[20];
    		static int cntr = 0;
    		sprintf(buffer, "counter = %d\r", cntr++);
    		netconn_write(newconn, (const unsigned char *)buffer, strlen(buffer), NETCONN_COPY);
    		vTaskDelay(1000);
    		osDelay(1);
    	}//whilw
    }//accept_err
	} //err
  }//conn
*/

  /* Infinite loop */
/*
for(;;)
  {
    osDelay(1);
  }
  */
  /* USER CODE END StartDefaultTask */
}

/* StartTask02 function */
void StartTask02(void const * argument)
{
  /* USER CODE BEGIN StartTask02 */
	uint8_t testDataToSend[128];
	uint8_t testDataToReceive[128];

//this maked	myBinarySem01_SPI1THandle = xSemaphoreCreateBinary();

	for (uint8_t i = 0; i < 128; i++)
	{
	    testDataToSend[i] = i + 1;
	}

   osSemaphoreRelease (myBinarySem01_SPI1THandle);
  /* Infinite loop */
  for(;;)
  {
	if(osSemaphoreWait(myBinarySem01_SPI1THandle , 1) == osOK) {
//	if(1) {
//	HAL_SPI_Transmit_DMA(&hspi1, testDataToSend, 128);
	HAL_SPI_TransmitReceive_DMA(&hspi1, testDataToSend, testDataToReceive, 128);
	HAL_GPIO_TogglePin( GPIOB, GPIO_PIN_7);
//	HAL_SPI_Receive_DMA(&hspi1, testDataToReceive, 128);
 //   HAL_Delay(1000);
	}
	//HAL_SPI_Receive_DMA(&hspi1, testDataToReceive, 128);
    osDelay(1);
  }
  /* USER CODE END StartTask02 */
}

/* StartTask03 function */
void StartTask03(void const * argument)
{
  /* USER CODE BEGIN StartTask03 */
	/*
#define TR_SIZE			(2)
	uint8_t testDataToSendU[TR_SIZE];
	uint16_t tmp, i;
	uint16_t cnt_rd = 0;
	uint16_t cnt_bf = 0;
	uint32_t cnt_rcv = 0;
	uint32_t cnt_tr = 0;
	uint32_t cnt_cp = 0;

	for (i = 0; i <  TR_SIZE	; i++)
		{
		    testDataToSendU[i] = i + 50;
		}

	uint8_t * testDataToReceiveU = malloc(U2_BUFF_SIZE);
	memset(testDataToReceiveU, 0, U2_BUFF_SIZE);
	memset(RcvBuff, 0 ,RCV_BUFF_SIZE);
	uint8_t flag_rcv = 0;
	uint16_t cnt = 0;
	uint32_t tcnt = 0;
	uint16_t rsize;
	uint16_t rsize_old = U2_BUFF_SIZE;
	char Buf[25];
    osSemaphoreRelease (myBinarySem02_USART2THandle);
    HAL_UART_Receive_DMA(&huart2,testDataToReceiveU, U2_BUFF_SIZE); //start receive
   for(;;)  {

		if(osSemaphoreWait(myBinarySem03_USART2RHandle , 1) == osOK) {
				cnt_rcv++;
			flag_rcv ++;
			}
	  rsize = (uint16_t) __HAL_DMA_GET_COUNTER(huart2.hdmarx);
   if(rsize < rsize_old) {
	   tmp = rsize_old - rsize;
   } else if(rsize > rsize_old) {
	   tmp = rsize_old + (uint16_t)U2_BUFF_SIZE - rsize;
   } else if(flag_rcv) {
	   tmp = rsize;
	   flag_rcv = 0;
   }
   rsize_old =  rsize;
	  if(tmp > 0) {
			HAL_GPIO_TogglePin( GPIOB, GPIO_PIN_14); //red
		  //if(tmp < 0) tmp += 128;
		  for(i = 0; i < tmp; i++) {
				Receive(testDataToReceiveU[cnt_bf]);
				testDataToReceiveU[cnt_bf] = 0;  //clear data
//			  testrdata[cnt_rd++] = testDataToReceiveU[cnt_bf++];
				cnt_bf++;
			  if(cnt_rd >= RD_SIZE) 		cnt_rd = 0;
			if(cnt_bf >= U2_BUFF_SIZE) 	cnt_bf = 0;
		  }
		  tmp = 0;
		  cnt_cp++;
	  } //tcnt
	  */



	  /*
		if(osSemaphoreWait(myBinarySem02_USART2THandle , 1) == osOK) {
		 cnt_tr++;
		 HAL_UART_Transmit_DMA(&huart2,testDataToSendU, TR_SIZE);
		 HAL_GPIO_TogglePin( GPIOB, GPIO_PIN_0);  //green
		 HAL_Delay(50);
		}
		*/
	  memset(RcvBuff, 0 ,RCV_BUFF_SIZE);
	//  ReadStorage();  //for have property ip
	//  My_ChangeIp();  //need add to remote
	  uint8_t * testDataToReceiveU = malloc(U2_BUFF_SIZE);
	  memset(testDataToReceiveU, 0, U2_BUFF_SIZE);
	  uint16_t cnt = 0;
	  uint32_t tcnt = 0;
	  uint16_t rsize;
	  uint16_t rsize_old = U2_BUFF_SIZE;
	  uint16_t tmp, i;
	  uint16_t cnt_rd = 0;
	  uint16_t cnt_bf = 0;
	 // uint32_t cnt_rcv = 0;
	 // uint32_t cnt_tr = 0;
	  uint32_t cnt_cp = 0;
	//  flag_rcv = 0;
	  char* Buf = malloc(25);
	  osSemaphoreRelease (myBinarySem02_USART2THandle);
	  HAL_UART_Receive_DMA(&huart2,testDataToReceiveU, U2_BUFF_SIZE); //start receive
	 //  IAP_tftpd_init(); //t
	  /* Infinite loop */
	  for(;;)
	  {
		//	if(osSemaphoreWait(myBinarySem03_USART2RHandle , 1) == osOK) {
				//	cnt_rcv++;
			//		flag_rcv ++;
			//		}
			 rsize = (uint16_t) __HAL_DMA_GET_COUNTER(huart2.hdmarx);
			 if(rsize < rsize_old) {
				   tmp = rsize_old - rsize;
			   } else if(rsize > rsize_old) {
				   tmp = rsize_old + (uint16_t)U2_BUFF_SIZE - rsize;
		//	   } else if(flag_rcv) {
			   }
			  // else if(flag_rcv > 1) {
				//   tmp = rsize;
			//	   tmp = 0;
			//	   flag_rcv = 0;
			 //  }
			   rsize_old =  rsize;
				  if(tmp > 0) {
						HAL_GPIO_TogglePin( GPIOB, GPIO_PIN_14); //red
					  for(i = 0; i < tmp; i++) {
							Receive(testDataToReceiveU[cnt_bf]);
							testDataToReceiveU[cnt_bf] = 0;  //clear data
						//	testrdata[cnt_rd++] = testDataToReceiveU[cnt_bf++];
							cnt_bf++;
						if(cnt_rd >= RD_SIZE) 		cnt_rd = 0;  //do not need
						if(cnt_bf >= U2_BUFF_SIZE) 	cnt_bf = 0;
					  }
					  tmp = 0;
					  cnt_cp++;
				  } //tcnt
	//  counter++;
	//  if(!(counter % 500)) {
	//   if(counter > TIME_WAIT_JUMP) {
	//	  HAL_UART_DMAStop(&huart2);
	//	  StartApp();
	 //  }
	//	  printfpd("\r> %d", counter / 500);
		//  HAL_Delay(100);
	//  }
		  CheckWriteStorage();
		  MyCheckLink();
		  osDelay(1);
  } //for
  /* USER CODE END StartTask03 */
}

/* USER CODE BEGIN Application */
/*
static void udp_thread1(void *arg)
{
	err_t err, recv_err;
	  struct netconn *conn;
	  struct netbuf *buf;
	  ip_addr_t *addr;
	  unsigned short port;
	  unsigned short my_port = MY_UDP_PORT;
	  void* data;  //my
	  u16_t len;//my
	  conn = netconn_new(NETCONN_UDP);
	  if (conn!= NULL) {
	    err = netconn_bind(conn, IP_ADDR_ANY, my_port);
      if (err == ERR_OK) {
    	  for(;;)  {
    		  recv_err = netconn_recv(conn, &buf);
    	//	  buf = netconn_recv(conn);
    		  if (recv_err == ERR_OK)  {
    	//	  if (buf != NULL)  {
    			  addr = netbuf_fromaddr(buf);
    			  port = netbuf_fromport(buf);
    			  netconn_connect(conn, addr, port);
    	//		  buf->addr = 0;//NULL;
    			  buf->addr.addr = 0;
    	//		  netbuf_data(buf, &data, &len);  //my
    	//		  netconn_write(conn, data, len, NETCONN_COPY);
    			  netconn_send(conn,buf);
    			  netbuf_delete(buf);
    			//  netconn_close(conn);
    		//	  netconn_delete(conn);
    		//	  conn = netconn_new(NETCONN_UDP);
    		//	  err = netconn_bind(conn, IP_ADDR_ANY, my_port);
    //			  osDelay(1);
    		  }
    		  osDelay(1);
    	   }
        }
	    else  {
	    		netconn_delete(conn);
	    	  }
	  }//conn
}
*/
static void udp_thread(void *arg)
{
//  struct_out *qstruct;
 // struct_sock *arg_sock;
  int sock, ret;
  struct sockaddr_in address, remotehost;
  socklen_t sockaddrsize;
//  arg_sock = (struct_sock*) arg;
  int buflen = 150;
  unsigned char recv_buffer[150];
  sockaddrsize = sizeof(remotehost);
  if ((sock = socket(AF_INET,SOCK_DGRAM, IPPROTO_UDP)) >= 0)
  {
    address.sin_family = AF_INET;
    address.sin_port = htons(MY_UDP_PORT);
    address.sin_addr.s_addr = INADDR_ANY;
    if (bind(sock, (struct sockaddr *)&address, sizeof (address)) ==  0)
    {
      for(;;)
      {
        ret = recvfrom( sock,recv_buffer, buflen, 0, (struct sockaddr *)&remotehost, &sockaddrsize);
        if(ret > 0)
        {
      //    qstruct = osMailAlloc(strout_Queue, osWaitForever);
      //    qstruct->x_pos = 0;
      //    qstruct->y_pos = arg_sock->y_pos;
      //    qstruct->sfont = Font24;
          recv_buffer[ret-1] = 0;
        //  sprintf(qstruct->str,"%5u %-20s", ntohs(remotehost.sin_port), (char*)recv_buffer);
        //  osMailPut(strout_Queue, qstruct);
        //  osDelay(2);
        //  sprintf(qstruct->str, "%7u",xPortGetMinimumEverFreeHeapSize());
        //  qstruct->y_pos = arg_sock->y_pos + 40;
        //  osMailPut(strout_Queue, qstruct);
        //  osMailFree(strout_Queue, qstruct);
          strcat((char*)recv_buffer,"\n");
          sendto(sock,recv_buffer,strlen((char*)recv_buffer),0,(struct sockaddr *)&remotehost, sockaddrsize);
        }
      }
    }
    else
    {
      close(sock);
      return;
    }
  }
}




void HAL_SPI_TxRxHalfCpltCallback(SPI_HandleTypeDef *hspi)
{
  /* Prevent unused argument(s) compilation warning */
  UNUSED(hspi);
//  osSemaphoreRelease (myBinarySem01_SPI1THandle);
  /* NOTE : This function should not be modified, when the callback is needed,
            the HAL_SPI_TxRxHalfCpltCallback() should be implemented in the user file
  */
}



void HAL_SPI_TxCpltCallback(SPI_HandleTypeDef *hspi)
{
  /* Prevent unused argument(s) compilation warning */

  UNUSED(hspi);
//  hspi->State = HAL_SPI_STATE_READY;
// osSemaphoreRelease (myBinarySem01_SPI1THandle);
  /* NOTE : This function should not be modified, when the callback is needed,
            the HAL_SPI_TxCpltCallback should be implemented in the user file
  */
}

void HAL_SPI_RxCpltCallback(SPI_HandleTypeDef *hspi)
{
  /* Prevent unused argument(s) compilation warning */
  UNUSED(hspi);
  /* NOTE : This function should not be modified, when the callback is needed,
            the HAL_SPI_RxCpltCallback should be implemented in the user file
  */
}


     
/* USER CODE END Application */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
